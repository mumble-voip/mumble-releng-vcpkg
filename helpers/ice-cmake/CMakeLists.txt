cmake_minimum_required(VERSION 3.1.0)

project(zeroc-ice)

set(zeroc-ice_VERSION_MAJOR 3)
set(zeroc-ice_VERSION_MINOR 7)
set(zeroc-ice_VERSION_PATCH 2)

set(zeroc-ice_CONFIG_FILES
   config/glacer2router.cfg
   config/ice_ca.cnf
   config/icegridnode.cfg
   config/icegridregistry.cfg
   config/Make.rules
   config/Make.xcodesdk.rules
   config/templates.xml
)

set(zeroc-ice_DOXYGEN_FILES
   doxygen/config-cpp11
   doxygen/config-cpp98
   doxygen/mainpage-cpp11.md
   doxygen/mainpage-cpp98.md
)

set_source_files_properties(
   ${zeroc-ice_CONFIG_FILES} ${zeroc-ice_DOXYGEN_FILES}
      PROPERTIES HEADER_FILE_ONLY TRUE
)

# set the slice directory
set(SLICE_DIR ${CMAKE_SOURCE_DIR}/slice)

file(GLOB SLICES RELATIVE ${SLICE_DIR} ${SLICE_DIR}/*)

foreach(slice ${SLICES})
      CreateSlicesOutputDir(${slice})
endforeach()

find_package(bzip2 1.0 REQUIRED)
find_package(expat 2.1 REQUIRED)
find_package(openssl 1.0.0 REQUIRED)

include(ExternalProject)
ExternalProject_Add(zeroc-mcpp
   GIT_REPOSITORY https://github.com/zeroc-ice/mcpp.git
   GIT_TAG e9ec201de0f395ab4bf4af714d91093138a0c43d
)

ExternalProject_Add_Step(zeroc-mcpp copy-cmakelists
   COMMAND ${CMAKE_COMMAND} -E copy 
      ${CMAKE_SOURCE_DIR}/external/zeroc-mcpp/CMakeLists.txt
      ${PROJECT_BINARY_DIR}/zeroc-mcpp-prefix/src/zeroc-mcpp
   DEPENDEES download
)

add_library(mcpp STATIC IMPORTED)

add_subdirectory(cpp/src/IceUtil)
add_subdirectory(cpp/src/Slice)
add_subdirectory(cpp/src/slice2cpp)
add_subdirectory(cpp/src/Ice)
add_subdirectory(cpp/src/Glacier2Lib)
add_subdirectory(cpp/src/IceBox)

install(TARGETS iceutil DESTINATION lib)
install(TARGETS slice DESTINATION lib)
install(TARGETS slice2cpp DESTINATION bin)
install(TARGETS ice DESTINATION lib)
