find_package(bzip2 1.0 REQUIRED)
find_package(expat 2.1 REQUIRED)
find_package(openssl 1.0.0 REQUIRED)

# Add dependencies for C++ related project generation
if(MSVC OR BORLAND OR CMAKE_COMPILER_IS_GNUCXX)
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
      config/Make.rules
      config/Make.xcodesdk.rules
      config/templates.xml
   )

   set_source_files_properties(
   ${zeroc-ice_CONFIG_FILES} ${zeroc-ice_DOXYGEN_FILES}
      PROPERTIES HEADER_FILE_ONLY TRUE
   )

   set(GENERATED_SOURCE_DIR ${PROJECT_BINARY_DIR}/cpp/include/generated)
   if(NOT ${GENERATED_SOURCE_DIR})
      file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/cpp/include/generated)
   endif()

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

   add_subdirectory(src/IceUtil)
   add_subdirectory(src/Slice)
   add_subdirectory(src/slice2cpp)
   add_subdirectory(src/Ice)
   add_subdirectory(src/Glacier2Lib)
   add_subdirectory(src/IceBox)

endif(MSVC OR BORLAND OR CMAKE_COMPILER_IS_GNUCXX)

install(TARGETS iceutil DESTINATION lib)
install(TARGETS slice DESTINATION lib)
install(TARGETS slice2cpp DESTINATION bin)
install(TARGETS ice DESTINATION lib)
