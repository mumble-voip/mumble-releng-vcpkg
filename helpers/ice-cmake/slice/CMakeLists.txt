# add function to handle slice compiles
include(${PROJECT_SOURCE_DIR}/cmake/CompileSlices.cmake)

# create root path for .ice files
set(SLICE_DIR ${CMAKE_SOURCE_DIR}/slice)

# do a compiler language check
get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)

if("${languages}" MATCHES "CXX")
   set(SLICE_COMPILER slice2cpp)
endif()

add_subdirectory(Ice)
