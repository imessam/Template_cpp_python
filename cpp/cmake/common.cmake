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

# GStreamer
if(WIN32)
    # On Windows, GStreamer is typically installed via the installer to a known location
    set(GSTREAMER_ROOT "C:/gstreamer/1.0/x86_64" CACHE PATH "GStreamer install root on Windows")
    
    find_library(GSTREAMER_LIBRARY gst-1.0 PATHS ${GSTREAMER_ROOT}/lib)
    find_library(GSTREAMER_SDP_LIBRARY gstreamer-sdp-1.0 PATHS ${GSTREAMER_ROOT}/lib)
    find_library(GSTREAMER_APP_LIBRARY gstreamer-app-1.0 PATHS ${GSTREAMER_ROOT}/lib)
    find_library(GSTREAMER_VIDEO_LIBRARY gstreamer-video-1.0 PATHS ${GSTREAMER_ROOT}/lib)
    find_library(GSTREAMER_PBUF_UTILS_LIBRARY gstreamer-pbutils-1.0 PATHS ${GSTREAMER_ROOT}/lib)
    find_library(GSTREAMER_WEBRTC_LIBRARY gstreamer-webrtc-1.0 PATHS ${GSTREAMER_ROOT}/lib)
    
    if(GSTREAMER_LIBRARY)
        add_library(PkgConfig::gstreamer UNKNOWN IMPORTED)
        set_target_properties(PkgConfig::gstreamer PROPERTIES
            IMPORTED_LOCATION ${GSTREAMER_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${GSTREAMER_ROOT}/include/gstreamer-1.0
        )
    endif()
    
    if(GSTREAMER_SDP_LIBRARY)
        add_library(PkgConfig::gstreamer-sdp UNKNOWN IMPORTED)
        set_target_properties(PkgConfig::gstreamer-sdp PROPERTIES
            IMPORTED_LOCATION ${GSTREAMER_SDP_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${GSTREAMER_ROOT}/include/gstreamer-1.0
        )
    endif()
    
    if(GSTREAMER_APP_LIBRARY)
        add_library(PkgConfig::gstreamer-app UNKNOWN IMPORTED)
        set_target_properties(PkgConfig::gstreamer-app PROPERTIES
            IMPORTED_LOCATION ${GSTREAMER_APP_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${GSTREAMER_ROOT}/include/gstreamer-1.0
        )
    endif()
    
    if(GSTREAMER_VIDEO_LIBRARY)
        add_library(PkgConfig::gstreamer-video UNKNOWN IMPORTED)
        set_target_properties(PkgConfig::gstreamer-video PROPERTIES
            IMPORTED_LOCATION ${GSTREAMER_VIDEO_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${GSTREAMER_ROOT}/include/gstreamer-1.0
        )
    endif()
    
    if(GSTREAMER_PBUF_UTILS_LIBRARY)
        add_library(PkgConfig::gstreamer-pbutils UNKNOWN IMPORTED)
        set_target_properties(PkgConfig::gstreamer-pbutils PROPERTIES
            IMPORTED_LOCATION ${GSTREAMER_PBUF_UTILS_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${GSTREAMER_ROOT}/include/gstreamer-1.0
        )
    endif()
    
    if(GSTREAMER_WEBRTC_LIBRARY)
        add_library(PkgConfig::gstreamer-webrtc UNKNOWN IMPORTED)
        set_target_properties(PkgConfig::gstreamer-webrtc PROPERTIES
            IMPORTED_LOCATION ${GSTREAMER_WEBRTC_LIBRARY}
            INTERFACE_INCLUDE_DIRECTORIES ${GSTREAMER_ROOT}/include/gstreamer-1.0
        )
    endif()
    
    message(STATUS "GStreamer root: ${GSTREAMER_ROOT}")
else()
    # On Linux, use pkg-config to find GStreamer
    find_package(PkgConfig REQUIRED)
    if (PkgConfig_FOUND)
        message(STATUS "PkgConfig version: ${PkgConfig_VERSION}")
        pkg_search_module(gstreamer REQUIRED IMPORTED_TARGET gstreamer-1.0>=1.4)
        pkg_search_module(gstreamer-sdp REQUIRED IMPORTED_TARGET gstreamer-sdp-1.0>=1.4)
        pkg_search_module(gstreamer-app REQUIRED IMPORTED_TARGET gstreamer-app-1.0>=1.4)
        pkg_search_module(gstreamer-video REQUIRED IMPORTED_TARGET gstreamer-video-1.0>=1.4)
        pkg_search_module(gstreamer-pbutils REQUIRED IMPORTED_TARGET gstreamer-pbutils-1.0>=1.4)
        pkg_search_module(gstreamer-webrtc REQUIRED IMPORTED_TARGET gstreamer-webrtc-1.0>=1.4)
        if (gstreamer_FOUND)
            message(STATUS "GStreamer version: ${gstreamer_VERSION}")
            include_directories(${gstreamer_INCLUDE_DIRS})
        else()
            message(FATAL_ERROR "GStreamer not found")
        endif ()
    else()
        message(FATAL_ERROR "PkgConfig not found")
    endif ()
endif ()
# !GStreamer

# Boost
find_package(Boost REQUIRED)
find_package(Boost REQUIRED COMPONENTS json)
if (Boost_FOUND)
    message(STATUS "Boost version: ${Boost_VERSION}")
    include_directories(${Boost_INCLUDE_DIRS})
else()
    message(FATAL_ERROR "Boost not found")
endif ()
# !Boost

