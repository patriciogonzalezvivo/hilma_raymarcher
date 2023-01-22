cmake_minimum_required(VERSION 3.2)

cmake_policy(SET CMP0104 NEW)

project(raymarcher LANGUAGES CXX CUDA)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_compile_options(-DGLM_FORCE_CXX11 -DGLM_FORCE_SWIZZLE -Wno-psabi -Wno-dev --no-warnings) 
add_subdirectory(deps)

set(CMAKE_CUDA_STANDARD 17)
set(CMAKE_CUDA_STANDARD_REQUIRED ON)

# # CUDA
# include(FindCUDA/select_compute_arch)
# CUDA_DETECT_INSTALLED_GPUS(INSTALLED_GPU_CCS_1)
# string(STRIP "${INSTALLED_GPU_CCS_1}" INSTALLED_GPU_CCS_2)
# string(REPLACE " " ";" INSTALLED_GPU_CCS_3 "${INSTALLED_GPU_CCS_2}")
# string(REPLACE "." "" CUDA_ARCH_LIST "${INSTALLED_GPU_CCS_3}")
# SET(CMAKE_CUDA_ARCHITECTURES ${CUDA_ARCH_LIST})

#Searching CUDA
find_package(CUDA REQUIRED)
include_directories(${CUDA_INCLUDE_DIRS})
message(STATUS ${CUDA_VERSION})
message(STATUS ${CUDA_TOOLKIT_ROOT_DIR})
include_directories("${PROJECT_SOURCE_DIR}/deps/lygia/include")

file(GLOB ROOT_SOURCE 
"${PROJECT_SOURCE_DIR}/src/*.cu"
"${PROJECT_SOURCE_DIR}/src/*.cpp"
)

add_executable(${PROJECT_NAME} ${ROOT_SOURCE})

# CUDA includes / linkage
set_target_properties(${PROJECT_NAME} PROPERTIES
	CUDA_RESOLVE_DEVICE_SYMBOLS ON
	CUDA_SEPARABLE_COMPILATION ON
)

# # copy all files on assets on the build folder
# file(COPY   assets/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )

target_link_libraries(${PROJECT_NAME} PRIVATE hilma ${CUDA_LIBRARIES})
target_link_libraries(${PROJECT_NAME} PUBLIC ${CUDA_LIBRARIES})
