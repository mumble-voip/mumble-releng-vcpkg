ExternalProject_Get_Property(zeroc-mcpp SOURCE_DIR)
ExternalProject_Get_Property(zeroc-mcpp BINARY_DIR)

#include_directories(${INSTALL_DIR}/include)
add_executable(slice2cpp Main.cpp Slice2Cpp.rc)

add_dependencies(slice2cpp zeroc-mcpp)

target_sources(slice2cpp 
   PRIVATE
      Gen.cpp
	   Gen.h
)

target_include_directories(slice2cpp
   PRIVATE
	  ${CMAKE_SOURCE_DIR}/cpp/include
	  ${CMAKE_SOURCE_DIR}/cpp/src
     ${SOURCE_DIR}/include
)

target_link_libraries(slice2cpp 
   ${BINARY_DIR}/lib/mcpp.lib
   iceutil 
   slice
)

if(WIN32)
   if(MSVC)
      target_compile_definitions(slice2cpp PRIVATE 
         "ICE_BUILDING_SLICE_COMPILERS" 
         "ICE_STATIC_LIBS"
      )

      target_compile_options(${ICE_COMPILE_OPTIONS})
      
      target_link_libraries(slice2cpp 
         rpcrt4.lib
         advapi32.lib
         DbgHelp.lib
         Shlwapi.lib
      )
      
      set(rc_flags " /l 0x0409 /D ${ICE_RC_FLAGS}")
      set(CMAKE_RC_FLAGS ${rc_flags})
      set_target_properties(slice2cpp PROPERTIES LINK_FLAGS "wsetargv.obj")
   endif()
endif()
