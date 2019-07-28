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

install(TARGETS iceutil DESTINATION lib)
install(TARGETS slice DESTINATION lib)
install(TARGETS slice2cpp DESTINATION bin)
install(TARGETS ice DESTINATION lib)
