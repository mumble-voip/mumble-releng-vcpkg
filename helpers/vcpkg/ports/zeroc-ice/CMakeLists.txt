cmake_minimum_required(VERSION 3.7.2)

# handle debug lib naming based on shipped project naming
if(NOT CMAKE_DEBUG_POSTFIX)
	set(CMAKE_DEBUG_POSTFIX d)
endif()

project(zeroc-ice)

set(zeroc-ice_VERSION_MAJOR 3)
set(zeroc-ice_VERSION_MINOR 7)
set(zeroc-ice_VERSION_PATCH 3)

option(BUILD_ICE_TESTS OFF)
option(BUILD_ICE_ALL OFF)
option(BUILD_ICE_CXX OFF)

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

if(BUILD_ICE_CXX)
	enable_language(CXX)
endif()

# do a compiler language check
get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)

# check language type, add subdirectories
if("${languages}" MATCHES "CXX")
	add_subdirectory(cpp)
elseif ("${languages}" MATCHES "CSharp")
	add_subdirectory(csharp)
elseif("${languages" MATCHES "Java")
	add_subdirectory(java)
endif()
