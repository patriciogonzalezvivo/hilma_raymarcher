# Install script for directory: /home/patricio/Desktop/hilma_raymarcher/deps/hilma/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/home/patricio/Desktop/hilma_raymarcher/build/deps/hilma/src/libhilma.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/hilma" TYPE FILE FILES
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/fs.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/math.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/text.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/timer.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/hilma/io" TYPE FILE FILES
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/io/auto.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/io/gltf.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/io/hdr.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/io/jpg.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/io/obj.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/io/ply.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/io/png.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/io/stl.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/hilma/ops" TYPE FILE FILES
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/ops/compute.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/ops/convert_image.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/ops/convert_path.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/ops/generate.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/ops/intersection.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/ops/raytrace.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/ops/transform.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/hilma/types" TYPE FILE FILES
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/types/Camera.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/types/Image.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/types/Line.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/types/Material.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/types/Mesh.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/types/Plane.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/types/Polygon.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/types/Polyline.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/types/Ray.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/types/Triangle.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/hilma/accel" TYPE FILE FILES
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/accel/BVH.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/accel/BoundingBox.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/accel/BoundingSphere.h"
    "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/include/hilma/accel/KdTree.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/usr/local/lib/python3.10/dist-packages/hilma/_hilma.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/lib/python3.10/dist-packages/hilma/_hilma.so")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/usr/local/lib/python3.10/dist-packages/hilma/_hilma.so"
         RPATH "")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/python3.10/dist-packages/hilma/_hilma.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/usr/local/lib/python3.10/dist-packages/hilma" TYPE MODULE FILES "/home/patricio/Desktop/hilma_raymarcher/build/deps/hilma/src/_hilma.so")
  if(EXISTS "$ENV{DESTDIR}/usr/local/lib/python3.10/dist-packages/hilma/_hilma.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/usr/local/lib/python3.10/dist-packages/hilma/_hilma.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}/usr/local/lib/python3.10/dist-packages/hilma/_hilma.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/python3.10/dist-packages/hilma/__init__.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/usr/local/lib/python3.10/dist-packages/hilma" TYPE FILE FILES "/home/patricio/Desktop/hilma_raymarcher/deps/hilma/__init__.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/lib/python3.10/dist-packages/hilma/hilma.py")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  file(INSTALL DESTINATION "/usr/local/lib/python3.10/dist-packages/hilma" TYPE FILE FILES "/home/patricio/Desktop/hilma_raymarcher/build/deps/hilma/src/hilma.py")
endif()

