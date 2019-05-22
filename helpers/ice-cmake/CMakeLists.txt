cmake_minimum_required(VERSION 3.1.0)

project(zeroc-ice)

set(zeroc-ice_VERSION_MAJOR 3)
set(zeroc-ice_VERSION_MINOR 7)
set(zeroc-ice_VERSION_PATCH 2)

set(zeroc-ice_CONFIG_FILES
      "config/glacer2router.cfg"
      "config/ice_ca.cnf"
      "config/icegridnode.cfg"
      "config/icegridregistry.cfg"
      "config/Make.rules"
      "config/Make.xcodesdk.rules"
      "config/templates.xml"
)

set(zeroc-ice_DOXYGEN_FILES
   "doxygen/config-cpp11"
   "doxygen/config-cpp98"
   "doxygen/mainpage-cpp11.md"
   "doxygen/mainpage-cpp98.md"
)

set_source_files_properties(
   ${zeroc-ice_CONFIG_FILES} ${zeroc-ice_DOXYGEN_FILES}
      PROPERTIES HEADER_FILE_ONLY TRUE
)
# Add dependencies for C++ related project generation
if(MSVC OR BORLAND OR CMAKE_COMPILER_IS_GNUCXX)
   # Find the Microsoft mc.exe message compiler
   # Retrieved from: https://github.com/pocoproject/poco/blob/208d7be64b23f7dc90af32e68aadbb3abb50a9ff/cmake/PocoMacros.cmake#L9-L51
   #  CMAKE_MC_COMPILER - where to find mc.exe
   if (WIN32)
     # cmake has CMAKE_RC_COMPILER, but no message compiler
     if ("${CMAKE_GENERATOR}" MATCHES "Visual Studio" OR "${CMAKE_GENERATOR}" MATCHES "MinGW")
       # this path is only present for 2008+, but we currently require PATH to
       # be set up anyway
       get_filename_component(sdk_dir "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Microsoft SDKs\\Windows;CurrentInstallFolder]" REALPATH)
       # comment, most likely win7 related (reaching EoL by 2020/01)
      #get_filename_component(kit_dir "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows Kits\\Installed Roots;KitsRoot]" REALPATH)
       get_filename_component(kit81_dir "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows Kits\\Installed Roots;KitsRoot81]" REALPATH)
       get_filename_component(kit10_dir "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows Kits\\Installed Roots;KitsRoot10]" REALPATH)
       file(GLOB kit10_list ${kit10_dir}/bin/10.*)
       if (X64)
         set(sdk_bindir "${sdk_dir}/bin/x64")
         set(kit_bindir "${kit_dir}/bin/x64")
         set(kit81_bindir "${kit81_dir}/bin/x64")
         foreach (tmp_elem ${kit10_list})
           if (IS_DIRECTORY ${tmp_elem})
           list(APPEND kit10_bindir "${tmp_elem}/x64")
           endif()
         endforeach()
       else (X64)
         set(sdk_bindir "${sdk_dir}/bin")
         set(kit_bindir "${kit_dir}/bin/x86")
         set(kit81_bindir "${kit81_dir}/bin/x86")
         foreach (tmp_elem ${kit10_list})
           if (IS_DIRECTORY ${tmp_elem})
           list(APPEND kit10_bindir "${tmp_elem}/x86")
           endif()
         endforeach()
       endif (X64)
     endif ()
     find_program(CMAKE_MC_COMPILER NAMES mc.exe windmc.exe HINTS "${sdk_bindir}" "${kit_bindir}" "${kit81_bindir}" ${kit10_bindir}
       DOC "path to message compiler")
     if(NOT CMAKE_MC_COMPILER AND MSVC)
       message(FATAL_ERROR "message compiler not found: required to build")
     endif(NOT CMAKE_MC_COMPILER AND MSVC)
     if(CMAKE_MC_COMPILER)
       message(STATUS "Found message compiler: ${CMAKE_MC_COMPILER}")
       mark_as_advanced(CMAKE_MC_COMPILER)
     endif(CMAKE_MC_COMPILER)
   endif(WIN32)

   # ZeroC sets the slices dir
   set(SLICES_DIR "${CMAKE_SOURCE_DIR}/slice")
   file(MAKE_DIRECTORY "${PROJECT_BINARY_DIR}/include/generated")

   #find_package(bzip2 1.0 REQUIRED)
   #find_package(expat 2.1 REQUIRED)
   #find_package(mcpp 2.7.2 REQUIRED)

   if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
      #find_package(openssl 1.0.0 REQUIRED)
   endif()


   add_subdirectory(../mcpp mcpp)

   list(APPEND COMPILED_SLICE_TYPES_CXX ".h" ".cpp")

   add_subdirectory(cpp/src/IceUtil)
   add_subdirectory(cpp/src/Slice)
   add_subdirectory(cpp/src/slice2cpp)
   add_subdirectory(cpp/src/Ice)
   add_subdirectory(cpp/src/Glacier2)
   add_subdirectory(cpp/src/IceBox)
   
endif(MSVC OR BORLAND OR CMAKE_COMPILER_IS_GNUCXX)

include("cmake/CompileSlices.cmake")
