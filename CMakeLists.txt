cmake_minimum_required(VERSION 3.2)

project(raytracer LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_compile_options(-DGLM_FORCE_CXX11 -DGLM_FORCE_SWIZZLE -Wno-psabi) 
add_subdirectory(deps)

file(GLOB ROOT_SOURCE 
    "${PROJECT_SOURCE_DIR}/src/*.cpp"
)

add_executable(raytracer
    ${ROOT_SOURCE}
)

set_target_properties(raytracer PROPERTIES
    CXX_STANDARD 11
    CXX_STANDARD_REQUIRED ON
    CMAKE_CXX_EXTENSIONS OFF
)

# copy all files on assets on the build folder
file(COPY   assets/ DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )

target_link_libraries(raytracer PRIVATE hilma)


