# Add dependencies for C++ related project generation

# todo: set up for Apple, might be needed here or obj-c
# if(MACOSX)
# set(zeroc-ice_CONFIG_FILES
#   config/Make.xcodesdk.rules
#)

# todo: add GNU Make logic to handle config/Make.rules if needed

set(zeroc-ice_DOXYGEN_FILES
   doxygen/config-cpp11
   doxygen/config-cpp98
   doxygen/mainpage-cpp11.md
   doxygen/mainpage-cpp98.md
)

set(zeroc-ice_CONFIG_FILES
   config/glacer2router.cfg
   config/ice_ca.cnf
   config/icegridnode.cfg
   config/icegridregistry.cfg
   config/templates.xml
)

set_source_files_properties(
${zeroc-ice_CONFIG_FILES} ${zeroc-ice_DOXYGEN_FILES}
   PROPERTIES HEADER_FILE_ONLY TRUE
)

# set the slice ice directory
set(SLICE_DIR ${CMAKE_SOURCE_DIR}/slice)

file(GLOB SLICES RELATIVE ${SLICE_DIR} ${SLICE_DIR}/*)

set(GENERATED_SOURCE_DIR ${PROJECT_BINARY_DIR}/cpp/include/generated)
if(NOT ${GENERATED_SOURCE_DIR})
   file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/cpp/include/generated)
endif()

include(${CMAKE_SOURCE_DIR}/cmake/CreateSlicesOutputDir.cmake)

foreach(slice ${SLICES})
      CreateSlicesOutputDir(${slice} ${GENERATED_SOURCE_DIR})
endforeach()

include(cmake/ice_cpp_props.cmake)

if(WIN32)
   include(cmake/mc_compiler.cmake)
endif(WIN32)

include(ExternalProject)
ExternalProject_Add(zeroc-mcpp
   GIT_REPOSITORY https://github.com/zeroc-ice/mcpp.git
   GIT_TAG e9ec201de0f395ab4bf4af714d91093138a0c43d
)

ExternalProject_Add_Step(zeroc-mcpp copy-cmakelists
   COMMAND ${CMAKE_COMMAND} -E copy 
      ${CMAKE_SOURCE_DIR}/external/zeroc-mcpp/CMakeLists.txt
      ${PROJECT_BINARY_DIR}/cpp/zeroc-mcpp-prefix/src/zeroc-mcpp
   DEPENDEES download
)

ExternalProject_Get_property(zeroc-mcpp INSTALL_DIR)

add_library(mcpp STATIC IMPORTED)

find_package(bzip2 1.0 REQUIRED)
find_package(expat 2.1 REQUIRED)
find_package(openssl 1.0.0 REQUIRED)

add_subdirectory(src/IceUtil)
add_subdirectory(src/Slice)
add_subdirectory(src/slice2cpp)
add_subdirectory(src/Ice)
add_subdirectory(src/Glacier2Lib)
add_subdirectory(src/IceBox)

install(TARGETS ice DESTINATION lib)
