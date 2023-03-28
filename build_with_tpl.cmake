message(STATUS "Building with TPL")

set(vt_DIR "" CACHE STRING "Path to VT")
set(checkpoint_DIR "" CACHE STRING "Path to checkpoint")

# Create symbolic links for adding as a subdirectory to test with all DARMA
# libraries at the same level
execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${vt_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/TPL/vt)
execute_process(COMMAND ${CMAKE_COMMAND} -E create_symlink ${checkpoint_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/TPL/checkpoint)

add_subdirectory(TPL/checkpoint)
add_subdirectory(TPL/vt)

#################### VT RUNTIME SAMPLE #####################
set(RUNTIME_SAMPLE vt-runtime-sample)

add_executable(
  ${RUNTIME_SAMPLE}
  "${CMAKE_SOURCE_DIR}/vt-runtime/src/sample.h"
  "${CMAKE_SOURCE_DIR}/vt-runtime/src/sample.cc"
)

target_link_libraries(${RUNTIME_SAMPLE} PUBLIC checkpoint)
target_link_libraries(${RUNTIME_SAMPLE} PUBLIC vt)
############################################################

################### VT TRACE-ONLY SAMPLE ###################
set(TRACE_ONLY_SAMPLE vt-trace-only-sample)

add_executable(
  ${TRACE_ONLY_SAMPLE}
  "${CMAKE_SOURCE_DIR}/vt-trace-only/src/sample.cc"
)

target_link_libraries(${TRACE_ONLY_SAMPLE} PUBLIC checkpoint)
target_link_libraries(${TRACE_ONLY_SAMPLE} PUBLIC vt-trace)
############################################################
