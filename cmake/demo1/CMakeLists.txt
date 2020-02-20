cmake_minimum_required(VERSION 2.8.11)
project(cmake)

aux_source_directory(. DIR_SRCS)

add_executable(cmake ${DIR_SRCS})
