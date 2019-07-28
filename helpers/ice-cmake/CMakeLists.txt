cmake_minimum_required(VERSION 3.1.0)

project(zeroc-ice)

set(zeroc-ice_VERSION_MAJOR 3)
set(zeroc-ice_VERSION_MINOR 7)
set(zeroc-ice_VERSION_PATCH 2)

get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)

# check language type, add subdirectories
if("${languages}" MATCHES "CXX")
   add_subdirectory(cpp)
elseif ("${languages}" MATCHES "CSharp")
   add_subdirectory(csharp)
elseif("${languages" MATCHES "Java")
   add_subdirectory(java)

endif()