cmake_minimum_required(VERSION 3.2)

project(raymarcher LANGUAGES CUDA CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

#Searching CUDA
find_package(CUDA REQUIRED)
include_directories(${CUDA_INCLUDE_DIRS})
message(STATUS ${CUDA_VERSION})
message(STATUS ${CUDA_TOOLKIT_ROOT_DIR})

# cuda_add_executable (people_detect src/people_detect.cpp)

add_compile_options(-DGLM_FORCE_CXX11 -DGLM_FORCE_SWIZZLE -Wno-psabi -Wno-dev) 
add_subdirectory(deps)

file(GLOB ROOT_SOURCE 
    "${PROJECT_SOURCE_DIR}/src/*.cu"
    "${PROJECT_SOURCE_DIR}/src/*.cpp"
)

add_executable(raymarcher
    ${ROOT_SOURCE}
)

# # copy all files on assets on the build folder
# file(COPY   assets/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )

target_link_libraries(raymarcher PRIVATE hilma)
