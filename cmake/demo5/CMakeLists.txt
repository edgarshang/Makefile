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

install (TARGETS cmake DESTINATION bin)

install (FILES "${PROJECT_BINARY_DIR}/config.h"

DESTINATION include)


# 启用测试

enable_testing()

# 测试程序是否成功运行

add_test (test_run cmake 5 2)

# 测试帮助信息是否可以正常提示

add_test (test_usage cmake)

set_tests_properties (test_usage

PROPERTIES PASS_REGULAR_EXPRESSION "Usage: .* base exponent")

# 测试 5 的平方

add_test (test_5_2 cmake 5 2)

set_tests_properties (test_5_2

PROPERTIES PASS_REGULAR_EXPRESSION "is 25")

# 测试 10 的 5 次方

add_test (test_10_5 cmake 10 5)

set_tests_properties (test_10_5

PROPERTIES PASS_REGULAR_EXPRESSION "is 100000")

# 测试 2 的 10 次方

add_test (test_2_10 cmake 2 10)

set_tests_properties (test_2_10

PROPERTIES PASS_REGULAR_EXPRESSION "is 1024")