cmake_minimum_required(VERSION 2.8.11)
project(cmake)

configure_file(

"${PROJECT_SOURCE_DIR}/config.h.in"

"${PROJECT_BINARY_DIR}/config.h"

)

option (USE_MYMATH

"Use provided math implementation" ON)

if (USE_MYMATH)

include_directories ("${PROJECT_SOURCE_DIR}/math")


add_subdirectory(math)

set (EXTRA_LIBS ${EXTRA_LIBS} mymath)

endif (USE_MYMATH)

aux_source_directory(. DIR_SRCS)

add_executable(cmake ${DIR_SRCS})

target_link_libraries(cmake ${EXTRA_LIBS})
