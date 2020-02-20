# CMake generated Testfile for 
# Source directory: /home/SENSETIME/shangzhiqiang/edgarGit/Makefile/cmake/demo5
# Build directory: /home/SENSETIME/shangzhiqiang/edgarGit/Makefile/cmake/demo5
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(test_run "cmake" "5" "2")
add_test(test_usage "cmake")
set_tests_properties(test_usage PROPERTIES  PASS_REGULAR_EXPRESSION "Usage: .* base exponent")
add_test(test_5_2 "cmake" "5" "2")
set_tests_properties(test_5_2 PROPERTIES  PASS_REGULAR_EXPRESSION "is 25")
add_test(test_10_5 "cmake" "10" "5")
set_tests_properties(test_10_5 PROPERTIES  PASS_REGULAR_EXPRESSION "is 100000")
add_test(test_2_10 "cmake" "2" "10")
set_tests_properties(test_2_10 PROPERTIES  PASS_REGULAR_EXPRESSION "is 1024")
subdirs(math)
