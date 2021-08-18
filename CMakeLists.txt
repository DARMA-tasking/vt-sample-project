cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(vt-sample)

set(CMAKE_CXX_STANDARD 14)

option(build_with_tpl "Build sample project using vt source code" OFF)
option(build_with_libs "Build sample project using vt compiled to library" OFF)

if(build_with_tpl)
  include(build_with_tpl.cmake)
elseif(build_with_libs)
  include(build_with_libs.cmake)
else()
  message(FATAL_ERROR "Set compilation mode to either build_with_tpl or build_with_libs.")
endif()
