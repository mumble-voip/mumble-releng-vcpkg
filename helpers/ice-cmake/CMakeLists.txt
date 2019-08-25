cmake_minimum_required(VERSION 3.1.0)

# shipped zeroc-ice shows two configurations defined here
if(CMAKE_CONFIGURATION_TYPES)
   set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)
endif()

project(zeroc-ice)

set(zeroc-ice_VERSION_MAJOR 3)
set(zeroc-ice_VERSION_MINOR 7)
set(zeroc-ice_VERSION_PATCH 2)

# add function to handle slice compiles
include(${PROJECT_SOURCE_DIR}/cmake/CompileSlices.cmake)

# create root path for .ice files
set(SLICE_DIR ${CMAKE_SOURCE_DIR}/slice)

# do a compiler language check
get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)

# check language type, add subdirectories
if("${languages}" MATCHES "CXX")
   if(WIN32)
      # remove related compiler flags that are not supported for win32
      string(REPLACE "/D_WINDOWS" "" CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS})
      # as of 8/2019, 8.1 is the lowest long term Windows version (supported until 1/2023),
      # defines for 8.1 which should be available in current SDK's
      # see this site for guidance: 
      # https://docs.microsoft.com/en-us/cpp/porting/modifying-winver-and-win32-winnt
      string(REPLACE "/DWIN32" "/D_WIN32_WINNT=0x603" CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS})
   endif()
   add_subdirectory(cpp)
elseif ("${languages}" MATCHES "CSharp")
   add_subdirectory(csharp)
elseif("${languages" MATCHES "Java")
   add_subdirectory(java)

endif()

add_subdirectory(slice)
