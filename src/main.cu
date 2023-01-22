#include <stdio.h>
#include <iostream>
#include <string>
#include <chrono>

#include <cuda_runtime.h>
#include <device_launch_parameters.h>
// #include "curand_kernel.h"
#define BLOCK_SIZE 8

#include "hilma/types/Image.h"
#include "hilma/ops/convert_image.h"
#include "hilma/io/png.h"

#include "lygia/math/sum.cuh"
#include "lygia/math/cross.cuh"
#include "lygia/math/floor.cuh"
#include "lygia/math/fract.cuh"
#include "lygia/math/reflect.cuh"
#include "lygia/math/normalize.cuh"
#include "lygia/math/operations.cuh"
#include "lygia/math/smoothstep.cuh"
#include "lygia/space/ratio.cuh"
#include "lygia/sdf/sphereSDF.cuh"
#include "lygia/sdf/planeSDF.cuh"
#include "lygia/sdf/opUnion.cuh"
#include "lygia/color/palette/hue.cuh"
#include "lygia/lighting/camera.cuh"

#define RAYMARCH_MAP_TYPE float4
#define RAYMARCH_SAMPLES 64
#define RAYMARCH_MAP_FNC(POS) raymarchMap(POS)
#define RAYMARCH_MAP_DISTANCE w
#define RAYMARCH_MAP_MATERIAL rgb

#define LIGHT_POSITION make_float3(0.0f, 10.0f, -50.0f)
#define LIGHT_COLOR make_float3(0.5f, 0.5f, 0.5f)
#define RAYMARCH_AMBIENT make_float3(1.0f, 1.0f, 1.0f)
#define RAYMARCH_BACKGROUND ( make_float3(0.7f, 0.9f, 1.0f) + ray.y * 0.8f )
// #define RAYMARCH_MAP_MATERIAL_TYPE float3

__device__ float checkBoard(float2 _uv, float2 _scale) {
    _uv = floor(fract(_uv * _scale) * 2.0);
    return min(1.0, _uv.x + _uv.y) - (_uv.x * _uv.y);
}

__device__ float4 raymarchMap(const float3& pos ) {
    float4 res = make_float4(1.0f);

    float check = checkBoard( make_float2(pos.x, pos.z), make_float2(1.0f));
    res = opUnion( res, make_float4( make_float3( 0.5f + check * 0.5f), planeSDF(pos) ) );
    res = opUnion( res, make_float4( 1.0f, 1.0f, 1.0f, sphereSDF(    pos - make_float3( 0.0f, 0.60f, 0.0f), 0.5f ) ) );
        
    return res;
}

__device__ float4 raymarchCast(const float3& ro, const float3& rd) {
    float tmin = 1.0;
    float tmax = 20.0;
    
    float t = tmin;
    float4 m = make_float4(-1.0);
    for ( int i = 0; i < RAYMARCH_SAMPLES; i++ ) {
        float precis = 0.00001*t;
        RAYMARCH_MAP_TYPE res = RAYMARCH_MAP_FNC( ro + rd * t );
        if ( res.w < precis || t > tmax ) 
            break;
        t += res.w;
        m = res;
    }

    #if defined(RAYMARCH_BACKGROUND) || defined(RAYMARCH_FLOOR)
    if ( t > tmax ) 
        m = make_float4(-1.0);
    #endif

    m.w = t;
    return m;
}

__device__ float3 raymarchNormal(const float3& pos, float e) {
   const float2 offset = make_float2(1.0f, -1.0f);
   float3 offset_xyy = make_float3(offset.x, offset.y, offset.y);
   float3 offset_yyx = make_float3(offset.y, offset.y, offset.x);
   float3 offset_yxy = make_float3(offset.y, offset.x, offset.y);
   float3 offset_xxx = make_float3(offset.x, offset.x, offset.x);
   return normalize( offset_xyy * RAYMARCH_MAP_FNC( pos + offset_xyy * e ).RAYMARCH_MAP_DISTANCE +
                     offset_yyx * RAYMARCH_MAP_FNC( pos + offset_yyx * e ).RAYMARCH_MAP_DISTANCE +
                     offset_yxy * RAYMARCH_MAP_FNC( pos + offset_yxy * e ).RAYMARCH_MAP_DISTANCE +
                     offset_xxx * RAYMARCH_MAP_FNC( pos + offset_xxx * e ).RAYMARCH_MAP_DISTANCE );
}

__device__ float3 raymarchMaterial(float3 ray, float3 position, float3 normal, float3 color) {
    float3  env = RAYMARCH_AMBIENT;

    if ( sum(color) <= 0.0f ) 
        return RAYMARCH_BACKGROUND;

    float3 ref = reflect( ray, normal );
    float occ = 1.0f;//raymarchAO( position, normal );

    #if defined(LIGHT_DIRECTION)
    float3  lig = normalize( LIGHT_DIRECTION );
    #else
    float3  lig = normalize( LIGHT_POSITION - position);
    #endif
    
    float3 hal = normalize( lig-ray );
    float amb = saturate( 0.5f + 0.5f * normal.y );
    float dif = saturate( dot( normal, lig ) );
    float bac = saturate( dot( normal, normalize( make_float3(-lig.x, 0.0f,-lig.z))) ) * saturate( 1.0f - position.y );
    float dom = smoothstep( -0.1f, 0.1f, ref.y );
    float fre = pow( saturate(1.0+dot(normal,ray) ), 2.0f );
    
    // dif *= raymarchSoftShadow( position, lig, 0.02, 2.5 );
    // dom *= raymarchSoftShadow( position, ref, 0.02, 2.5 );

    float3 light = make_float3(0.0f);
    light += 1.30f * dif * LIGHT_COLOR;
    light += 0.40f * amb * occ * env;
    light += 0.50f * dom * occ * env;
    light += 0.50f * bac * occ * 0.25f;
    light += 0.25f * fre * occ;

    return color * light;
}

__device__ float3 raymarchNormal(const float3& pos) {
    return raymarchNormal(pos, 0.5773f * 0.0005f);
}

__global__ void render(int _width, int _height, float *_pixels, Camera _cam) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= _width || y >= _height)
        return;

    float2 resolution = make_float2(_width, _height);
    float2 pixel = 1.0f / resolution;
    float2 st = make_float2(x, y) * pixel;
    st = ratio(st, resolution);

    float2 uv = st * 2.0 - 1.0;
    float3 ray_origin = _cam.pos;
    float3 ray_direction = normalize(_cam.side * uv.x + _cam.up * uv.y + _cam.dir * _cam.invhalffov);

    float4 res = raymarchCast(ray_origin, ray_direction);
    float t = res.w;

    float3 pos = ray_origin + t * ray_direction;
    float3 nor = raymarchNormal( pos );

    float3 albedo = make_float3( res.x, res.y, res.z );
    // float3 color = raymarchMaterial(ray_direction, pos, nor, albedo);
    float3 color = nor;

    // return color
    _pixels[x * 4 + 4 * y * _width + 0] = color.x;
    _pixels[x * 4 + 4 * y * _width + 1] = color.y;
    _pixels[x * 4 + 4 * y * _width + 2] = color.z;
    _pixels[x * 4 + 4 * y * _width + 3] = 1.0f;
}

int main(int argc, char **argv) {
    int width = 1920;
    int height = 1080;

    // Create a buffer of pixels to be process on __device__
    float *d_pixels;
    cudaMalloc(&d_pixels, 4 * width * height * sizeof(float));

    Camera cam;
	// cam.pos = make_float3(-1.0f, 1.5f, -1.0f);
	cam.pos = make_float3(0.0f, 1.0f, -0.6f);

	cam.dir = normalize( make_float3(0.0f, 0.0f, 0.6f) - cam.pos);
	cam.side = normalize(cross(cam.dir, make_float3(0.0f, 1.0f, 0.0f)));
	cam.up = normalize(cross(cam.side, cam.dir));
	float fov = 128.0f / 180.0f * float(M_PI);
	cam.invhalffov = 1.0f / std::tan(fov / 2.0f);

    // Hand the pixels to a kernel to be process on __device__ 
    dim3 threads(BLOCK_SIZE, BLOCK_SIZE);
    dim3 blocks(width / threads.x + 1, height / threads.y + 1);
    render<<<blocks, threads>>>(width, height, d_pixels, cam);

    // Copy pixels processed on __device__ into a HILMA Image on __host__
    hilma::Image image = hilma::Image(width, height, 4);
    cudaMemcpy(&image[0], d_pixels, 4 * width * height * sizeof(float), cudaMemcpyDeviceToHost);

    // Save image
    hilma::flip(image);
    hilma::savePng("image.png", image);

    // Free pixels on __device__
    cudaFree(d_pixels);

    return 0;
}