cmake_minimum_required(VERSION 3.15...3.31)

project(MyModuleTest VERSION 1.0
                  DESCRIPTION "My Module Test"
                  LANGUAGES CXX)

include(${CMAKE_CURRENT_LIST_DIR}/../cmake/common.cmake)

enable_testing()

add_executable(
  my_module_test

  ${CMAKE_CURRENT_LIST_DIR}/test_main.cpp

  ${CMAKE_CURRENT_LIST_DIR}/test_class_implemented_derived.cpp
)

target_include_directories(my_module_test PUBLIC ${CMAKE_CURRENT_LIST_DIR}/../include)
target_include_directories(my_module_test PUBLIC ${CMAKE_CURRENT_LIST_DIR}/../../test-libs/another_module/cpp/include)


target_link_libraries(
  my_module_test
  GTest::gtest_main
)

target_compile_features(my_module_test PUBLIC cxx_std_23)

  # if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24")
  #     # Enable Warnings as Errors (Modern CMake 3.24+)
  #     set_target_properties(my_module_test PROPERTIES 
  #         INTERFACE_COMPILE_WARNING_AS_ERROR ON
  #     )
  # else()
  #     # Enable warnings as errors
  #     target_compile_options(my_module_test PRIVATE -Wall -Wextra -Werror)
  # endif()

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
      set_target_properties(my_module_test PROPERTIES
          CXX_CLANG_TIDY "${CLANG_TIDY_ARGS}"
      )
    endif()


include(GoogleTest)
gtest_discover_tests(my_module_test)
