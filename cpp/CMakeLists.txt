cmake_minimum_required(VERSION 3.15...3.31)

project(MyModule VERSION 1.0
                  DESCRIPTION "My Module"
                  LANGUAGES CXX)

include(${CMAKE_CURRENT_LIST_DIR}/cmake/common.cmake)

option(ENABLE_TESTS "isEnableTests" ON)

set(DEPS 

  # yaml-cpp::yaml-cpp
  # PkgConfig::gstreamer
  # PkgConfig::gstreamer-sdp
  # PkgConfig::gstreamer-app
  # PkgConfig::gstreamer-video
  # PkgConfig::gstreamer-pbutils
  # ${OpenCV_LIBS}

)

set(EXECS)
set(LIBS)
set(TESTS)

## Libraries setup

include(${CMAKE_CURRENT_LIST_DIR}/src/CMakeLists.txt)

set(LIBS ${LIBS} MyModuleLib)

foreach(_lib
${LIBS})
  target_link_libraries(${_lib}
      ${DEPS}
    )
endforeach()


## Executables setup

add_executable(my_module_demo ${CMAKE_CURRENT_LIST_DIR}/demo.cpp)

set(EXECS ${EXECS} my_module_demo)

foreach(_target
${EXECS})
  target_link_libraries(${_target}
    ${DEPS}
    ${LIBS}
    )
endforeach()


## Tests setup

if(${ENABLE_TESTS})
  include(${CMAKE_CURRENT_LIST_DIR}/test/CMakeLists.txt)
  set(TESTS ${TESTS} my_module_test)
endif()

foreach(_test
${TESTS})
  target_link_libraries(${_test}
    ${DEPS}
    ${LIBS}
    )
endforeach()
