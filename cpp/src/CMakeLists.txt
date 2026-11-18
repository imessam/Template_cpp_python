cmake_minimum_required(VERSION 3.15...3.31)

project(MyModule VERSION 1.0
                  DESCRIPTION "My Module"
                  LANGUAGES CXX)

include(${CMAKE_CURRENT_LIST_DIR}/../cmake/common.cmake)

option(ENABLE_ASAN_UBSAN "Enable ASan + UBSan" OFF)
option(ENABLE_TSAN "Enable TSan" OFF)
option(ENABLE_MSAN "Enable MSan" OFF)

add_library(my_module_sanitizers INTERFACE)

if (ENABLE_ASAN_UBSAN)
    target_compile_options(my_module_sanitizers INTERFACE
      $<$<COMPILE_LANGUAGE:C,CXX>:-O1>
      $<$<COMPILE_LANGUAGE:C,CXX>:-fsanitize=address,undefined>
      $<$<COMPILE_LANGUAGE:C,CXX>:-fsanitize-address-use-after-scope>
    )
    target_link_options(my_module_sanitizers INTERFACE
      -fsanitize=address,undefined
    )
  endif()

  if (ENABLE_TSAN)
    target_compile_options(my_module_sanitizers INTERFACE
      $<$<COMPILE_LANGUAGE:C,CXX>:-O1>
      $<$<COMPILE_LANGUAGE:C,CXX>:-fsanitize=thread>
    )
    target_link_options(project_sanitizers INTERFACE
      -fsanitize=thread
    )
  endif()

  if (ENABLE_MSAN)
    target_compile_options(my_module_sanitizers INTERFACE
      $<$<COMPILE_LANGUAGE:C,CXX>:-O1>
      $<$<COMPILE_LANGUAGE:C,CXX>:-fsanitize=memory>
      $<$<COMPILE_LANGUAGE:C,CXX>:-fsanitize-memory-track-origins=2>
    )
    target_link_options(my_module_sanitizers INTERFACE
      -fsanitize=memory
    )
  endif()


## Libraries setup

set(MY_MODULE_SOURCES

  ${CMAKE_CURRENT_LIST_DIR}/class_abstract_base.cpp

  ${CMAKE_CURRENT_LIST_DIR}/class_implemented_derived.cpp

)

if (NOT TARGET my_module)

  add_library(my_module STATIC ${MY_MODULE_SOURCES})

  target_include_directories(my_module PUBLIC ${CMAKE_CURRENT_LIST_DIR}/../include)

  include(${CMAKE_CURRENT_LIST_DIR}/../../libs/CMakeLists.txt)

foreach(_lib_include_dir
  ${libs_include_my_module)
  target_include_directories(my_module PUBLIC
        ${_lib_include_dir}
      )
  endforeach()
  
set(DEPS 

  # yaml-cpp

  # PkgConfig::gstreamer
  # PkgConfig::gstreamer-sdp
  # PkgConfig::gstreamer-app
  # PkgConfig::gstreamer-video
  # PkgConfig::gstreamer-pbutils

  # ${OpenCV_LIBS}

)

arget_link_libraries(my_module PUBLIC ${DEPS} ${libs_targets_my_module})

  target_compile_features(my_module PUBLIC cxx_std_23)

  if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24")
      # Enable Warnings as Errors (Modern CMake 3.24+)
      set_target_properties(my_module PROPERTIES 
          INTERFACE_COMPILE_WARNING_AS_ERROR ON
      )
  else()
      # Enable warnings as errors
      target_compile_options(my_module PRIVATE -Wall -Wextra -Werror)
  endif()

   # Optional: Link Static Analysis (Clang-Tidy)
  find_program(CLANG_TIDY_EXE NAMES "clang-tidy")
  if(CLANG_TIDY_EXE)
      set(CLANG_TIDY_ARGS
          "${CLANG_TIDY_EXE}"
          "--fix"
          "--checks=-*,modernize*,cppcoreguidelines*,bugprone*,clang-analyzer*,concurrency*,google*,readability*,performance*,-bugprone-easily-swappable-parameters,-cppcoreguidelines-non-private-member-variables-in-classes"
          "--header-filter=^(?!.*(onnxruntime|opencv)).*$"
          "--extra-arg=-std=c++23"
      )
      set_target_properties(my_module PROPERTIES
          CXX_CLANG_TIDY "${CLANG_TIDY_ARGS}"
      )
    endif()

endif()
