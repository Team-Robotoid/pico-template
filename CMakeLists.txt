cmake_minimum_required(VERSION 3.25)

include(cmake/pico_sdk_import.cmake)
include(cmake/picotool_import.cmake)

project(i2c_workshop C CXX)
pico_sdk_init()

add_executable(
  master
)

target_sources(master PRIVATE src/main.c)

set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

target_link_libraries(master pico_stdlib)

pico_enable_stdio_usb(master 1)

pico_add_extra_outputs(master)

create_flash_target(master)
