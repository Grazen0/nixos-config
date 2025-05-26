cmake_minimum_required(VERSION {{ cmake_version }})
project({{ project_name }})

set(CMAKE_CXX_STANDARD {{ cpp_version }})
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -Og")

# Set default build type to Debug
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Debug)
endif()

file(GLOB_RECURSE SOURCE_FILES CONFIGURE_DEPENDS "src/*.h" "src/*.cpp")

add_executable({{ executable }} ${SOURCE_FILES})

if(MSVC)
  target_compile_options({{ executable }} PRIVATE /W4)
else()
  target_compile_options({{ executable }} PRIVATE -Wall -Wextra -Wpedantic)
endif()
