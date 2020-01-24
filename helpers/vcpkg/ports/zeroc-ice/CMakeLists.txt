cmake_minimum_required(VERSION 3.7.2)

# handle debug lib naming based on shipped project naming
if(NOT CMAKE_DEBUG_POSTFIX)
	set(CMAKE_DEBUG_POSTFIX d)
endif()

if(BUILD_ICE_CXX)
	project(zeroc-ice CXX)
elseif(BUILD_ICE_CS)
	project(zeroc-ice CSharp)
endif()

set(zeroc-ice_VERSION_MAJOR 3)
set(zeroc-ice_VERSION_MINOR 7)
set(zeroc-ice_VERSION_PATCH 3)

option(BUILD_ICE_TESTS OFF)
option(BUILD_ICE_ALL OFF)
option(BUILD_ICE_CXX OFF)
option(BUILD_ICE_CS OFF)

if(CMAKE_CONFIGURATION_TYPES)
	if(BUILD_ICE_TESTS)
		set(CMAKE_CONFIGURATION_TYPES "Debug" CACHE STRING "" FORCE)
	else()
		set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)
	endif()
endif()

# add function to handle slice compiles (icebuilder)
include(cmake/CompileSlice.cmake)

# create root path for .ice files
set(SLICE_DIR ${CMAKE_SOURCE_DIR}/slice)

# create include/generated folder for generated headers
if(NOT ${PROJECT_BINARY_DIR}/generated)
	file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated)
endif()

# generated sources build dir
set(GENERATED_SLICES_DIR ${PROJECT_BINARY_DIR}/generated)

# add project wide slices
include(cmake/Slices.cmake)

if(BUILD_ICE_CXX)
	enable_language(CXX)
elseif(BUILD_ICE_CS)
	enable_language(CSharp)
endif()

# do a compiler language check
get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)

# check language type, add subdirectories
if("${languages}" MATCHES "CXX")
	add_subdirectory(cpp)
elseif ("${languages}" MATCHES "CSharp")
	enable_language(CXX)
	include(${PROJECT_SOURCE_DIR}/cpp/cmake/ice_cpp_props.cmake)
	add_subdirectory(cpp/src/IceUtil)
	add_subdirectory(cpp/src/Slice)
	add_subdirectory(cpp/src/slice2cs)
	add_subdirectory(csharp)
elseif("${languages" MATCHES "Java")
	add_subdirectory(java)
endif()
