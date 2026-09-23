cmake_minimum_required(VERSION 3.15...3.31)


# OpenCV
find_package(OpenCV 4.0 REQUIRED)
if (OpenCV_FOUND)
    message(STATUS "OpenCV version: ${OpenCV_VERSION}")
    include_directories(${OpenCV_INCLUDE_DIRS})
else()
    message(FATAL_ERROR "OpenCV 4.0 not found")
endif ()
# !OpenCV

# Logger
find_package(Logger REQUIRED)
if (Logger_FOUND)
    message(STATUS "Logger version: ${Logger_VERSION}")
    include_directories(${Logger_INCLUDE_DIRS})
else()
    message(FATAL_ERROR "Logger not found")
endif ()
# !Logger

# GoogleTest
find_package(GTest REQUIRED)
if (GTest_FOUND)
    message(STATUS "GTest version: ${GTest_VERSION}")
else()
    message(FATAL_ERROR "GTest not found")
endif ()
# !GTest


# eigen
find_package(Eigen3 REQUIRED)
if (Eigen3_FOUND)
    message(STATUS "Eigen3 version: ${Eigen3_VERSION}")
    include_directories(${Eigen3_INCLUDE_DIRS})
else()
    message(FATAL_ERROR "Eigen3 not found")
endif ()
# !eigen

find_package(CURL REQUIRED)
if (CURL_FOUND)
    message(STATUS "CURL version: ${CURL_VERSION}")
else()
    message(FATAL_ERROR "CURL not found")
endif ()
# !CURL

# ONNX

set(ONNXRUNTIME_POSSIBLE_PATHS
  /opt/onnxruntime
  /usr/local/onnxruntime
  ${CMAKE_SOURCE_DIR}/third_party/onnxruntime
)

set(ONNXRUNTIME_FOUND FALSE)

foreach(ONNXRUNTIME_PATH IN LISTS ONNXRUNTIME_POSSIBLE_PATHS)
  if(EXISTS "${ONNXRUNTIME_PATH}/include/onnxruntime_c_api.h")
    set(ONNXRUNTIME_DIR "${ONNXRUNTIME_PATH}" CACHE PATH "ONNX Runtime directory" FORCE)
    set(ONNXRUNTIME_FOUND TRUE)
    message(STATUS "Found ONNX Runtime at: ${ONNXRUNTIME_PATH}")
    break()
  endif()
endforeach()

if(ONNXRUNTIME_FOUND)
  message(STATUS "ONNXRUNTIME_DIR: ${ONNXRUNTIME_DIR}")
  include_directories("${ONNXRUNTIME_DIR}/include")
else()
  message(WARNING "ONNX Runtime not found in any of the search paths. Please install ONNX Runtime or set ONNXRUNTIME_DIR manually.")
endif()
# !ONNX Runtime




find_package(PkgConfig REQUIRED)
pkg_search_module(gstreamer REQUIRED IMPORTED_TARGET gstreamer-1.0>=1.4)
pkg_search_module(gstreamer-sdp REQUIRED IMPORTED_TARGET gstreamer-sdp-1.0>=1.4)
pkg_search_module(gstreamer-app REQUIRED IMPORTED_TARGET gstreamer-app-1.0>=1.4)
pkg_search_module(gstreamer-video REQUIRED IMPORTED_TARGET gstreamer-video-1.0>=1.4)
pkg_search_module(gstreamer-pbutils REQUIRED IMPORTED_TARGET gstreamer-pbutils-1.0>=1.4)

