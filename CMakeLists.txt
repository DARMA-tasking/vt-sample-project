cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(vt-sample)

set(CMAKE_CXX_STANDARD 14)

find_package(vt REQUIRED)

file(
  GLOB
  HEADER_FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/src/*.h
)

file(
  GLOB
  SOURCE_FILES
  ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cc
)

add_executable(
  vt-sample
  ${HEADER_FILES} ${SOURCE_FILES}
)

target_include_directories(vt-sample PUBLIC vt::runtime::vt)
target_link_directories(vt-sample PUBLIC vt::runtime::vt)
