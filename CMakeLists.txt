cmake_minimum_required(VERSION 3.10 FATAL_ERROR)

project(vt-sample)

set(CMAKE_CXX_STANDARD 14)

find_package(vt REQUIRED)

#################### VT RUNTIME SAMPLE #####################
set(RUNTIME_SAMPLE vt-runtime-sample)

add_executable(
  ${RUNTIME_SAMPLE}
  "${CMAKE_SOURCE_DIR}/vt-runtime/src/sample.h"
  "${CMAKE_SOURCE_DIR}/vt-runtime/src/sample.cc"
)

target_link_libraries(${RUNTIME_SAMPLE} PUBLIC vt::runtime::vt)
############################################################

################### VT TRACE-ONLY SAMPLE ###################
set(TRACE_ONLY_SAMPLE vt-trace-only-sample)

add_executable(
  ${TRACE_ONLY_SAMPLE}
  "${CMAKE_SOURCE_DIR}/vt-trace-only/src/sample.h"
  "${CMAKE_SOURCE_DIR}/vt-trace-only/src/sample.cc"
)

target_link_libraries(${TRACE_ONLY_SAMPLE} PUBLIC vt::vt-trace)
############################################################