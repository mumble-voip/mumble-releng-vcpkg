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

find_package(bzip2 1.0 REQUIRED)
find_package(expat 2.1 REQUIRED)
find_package(openssl 1.0.0 REQUIRED)

install(TARGETS iceutil DESTINATION lib)
install(TARGETS slice DESTINATION lib)
install(TARGETS slice2cpp DESTINATION bin)
install(TARGETS ice DESTINATION lib)
