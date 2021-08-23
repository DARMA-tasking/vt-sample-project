message(STATUS "Building with libraries")

find_package(detector REQUIRED)
find_package(checkpoint REQUIRED)
find_package(vt REQUIRED)
find_package(MPI REQUIRED)

include_directories(SYSTEM ${MPI_INCLUDE_PATH})
include_directories(${VT_INCLUDE_DIRS})
include_directories(${CHECKPOINT_INCLUDE_DIRS})
include_directories(${DETECTOR_INCLUDE_DIRS})

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
  "${CMAKE_SOURCE_DIR}/vt-trace-only/src/sample.cc"
)

target_link_libraries(${TRACE_ONLY_SAMPLE} PUBLIC vt-trace)
############################################################
