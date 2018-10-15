cmake_minimum_required(VERSION 3.10.0)

find_package(is-msgs REQUIRED)
find_package(Boost REQUIRED filesystem)
find_package(spdlog REQUIRED)

add_executable(service.bin
  service.cpp 
)

target_link_libraries(
  service.bin
 PUBLIC 
  is-msgs::is-msgs
  Boost::filesystem
  spdlog::spdlog
)

target_include_directories(
  service.bin
 PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_LIST_DIR}> # for headers when building
  $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}> # for generated files in build mode
)

set_property(TARGET service.bin PROPERTY CXX_STANDARD 14)
