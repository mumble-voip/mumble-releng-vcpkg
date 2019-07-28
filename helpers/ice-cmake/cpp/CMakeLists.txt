# Add dependencies for C++ related project generation
if(MSVC OR BORLAND OR CMAKE_COMPILER_IS_GNUCXX)

   set(GENERATED_SOURCE_DIR ${PROJECT_BINARY_DIR}/cpp/include/generated)
   if(NOT ${GENERATED_SOURCE_DIR})
      file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/cpp/include/generated)
   endif()
   function(CreateSlicesOutputDir slice)
      if(NOT ${GENERATED_SOURCE_DIR}/${slice})
         file(MAKE_DIRECTORY ${GENERATED_SOURCE_DIR}/${slice})
      endif()
   endfunction()

   if(WIN32)
      include(cpp/cmake/ice_cpp_props.cmake)
      include(cpp/cmake/mc_compiler.cmake)
   endif(WIN32)

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


endif(MSVC OR BORLAND OR CMAKE_COMPILER_IS_GNUCXX)
