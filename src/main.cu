#include <stdio.h>
#include <iostream>
#include <string>
#include <chrono>

#include <cuda_runtime.h>
#include <device_launch_parameters.h>
// #include "curand_kernel.h"
#include "cutil_math.h"
#define BLOCK_SIZE 8

#include "hilma/types/Image.h"
#include "hilma/io/png.h"

__global__ void render(int _width, int _height, float *_pixels) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;
    if (x >= _width || y >= _height)
        return;

    float4 color = make_float4(0.0f, 0.0f, 0.0f, 1.0f);
    float2 pixel = make_float2(1.0 / _width, 1.0 / _height);
    float2 st = make_float2(x, y) * pixel;

    color.x = st.x;
    color.y = st.y;

    // return color
    _pixels[x * 4 + 4 * y * _width + 0] = color.x;
    _pixels[x * 4 + 4 * y * _width + 1] = color.y;
    _pixels[x * 4 + 4 * y * _width + 2] = color.z;
    _pixels[x * 4 + 4 * y * _width + 3] = color.w;
}

int main(int argc, char **argv) {
    int width = 1920;
    int height = 1080;

    // Create a buffer of pixels to be process on __device__
    float *d_pixels;
    cudaMalloc(&d_pixels, 4 * width * height * sizeof(float));

    // Hand the pixels to a kernel to be process on __device__ 
    dim3 threads(BLOCK_SIZE, BLOCK_SIZE);
    dim3 blocks(width / threads.x + 1, height / threads.y + 1);
    render<<<blocks, threads>>>(width, height, d_pixels);

    // Copy pixels processed on __device__ into a HILMA Image on __host__
    hilma::Image image = hilma::Image(width, height, 4);
    cudaMemcpy(&image[0], d_pixels, 4 * width * height * sizeof(float), cudaMemcpyDeviceToHost);

    // Save image
    hilma::savePng("image.png", image);

    // Free pixels on __device__
    cudaFree(d_pixels);

    return 0;
}