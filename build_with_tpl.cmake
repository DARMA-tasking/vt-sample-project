message(STATUS "Building with TPL")

set(vt_DIR "" CACHE STRING "Path to VT")
set(checkpoint_DIR "" CACHE STRING "Path to checkpoint")
set(detector_DIR "" CACHE STRING "Path to detector")

# Create symbolic links for adding as a subdirectory to test with all DARMA
# libraries at the same level
execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${vt_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/TPL/vt)
execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${checkpoint_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/TPL/checkpoint)
execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${detector_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/TPL/detector)

add_subdirectory(TPL/detector)
add_subdirectory(TPL/checkpoint)
add_subdirectory(TPL/vt)

#################### VT RUNTIME SAMPLE #####################
set(RUNTIME_SAMPLE vt-runtime-sample)

add_executable(
  ${RUNTIME_SAMPLE}
  "${CMAKE_SOURCE_DIR}/vt-runtime/src/sample.h"
  "${CMAKE_SOURCE_DIR}/vt-runtime/src/sample.cc"
)

target_link_libraries(${RUNTIME_SAMPLE} PUBLIC detector)
target_link_libraries(${RUNTIME_SAMPLE} PUBLIC checkpoint)
target_link_libraries(${RUNTIME_SAMPLE} PUBLIC vt)
############################################################

################### VT TRACE-ONLY SAMPLE ###################
set(TRACE_ONLY_SAMPLE vt-trace-only-sample)

add_executable(
  ${TRACE_ONLY_SAMPLE}
  "${CMAKE_SOURCE_DIR}/vt-trace-only/src/sample.cc"
)

target_link_libraries(${TRACE_ONLY_SAMPLE} PUBLIC detector)
target_link_libraries(${TRACE_ONLY_SAMPLE} PUBLIC checkpoint)
target_link_libraries(${TRACE_ONLY_SAMPLE} PUBLIC vt-trace)
############################################################
