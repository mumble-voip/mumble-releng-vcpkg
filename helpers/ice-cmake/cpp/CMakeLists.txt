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

endif(MSVC OR BORLAND OR CMAKE_COMPILER_IS_GNUCXX)
