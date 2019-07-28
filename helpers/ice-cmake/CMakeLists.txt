cmake_minimum_required(VERSION 3.1.0)

project(zeroc-ice)

set(zeroc-ice_VERSION_MAJOR 3)
set(zeroc-ice_VERSION_MINOR 7)
set(zeroc-ice_VERSION_PATCH 2)

function(CreateSlicesOutputDir slice)
   if(NOT ${GENERATED_SOURCE_DIR}/${slice})
      file(MAKE_DIRECTORY ${GENERATED_SOURCE_DIR}/${slice})
   endif()
endfunction()

# set the slice directory
set(SLICE_DIR ${CMAKE_SOURCE_DIR}/slice)

file(GLOB SLICES RELATIVE ${SLICE_DIR} ${SLICE_DIR}/*)

foreach(slice ${SLICES})
      CreateSlicesOutputDir(${slice})
endforeach()

get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)

if("${languages}" MATCHES "CXX")
   add_subdirectory(cpp)
endif()