
add_executable(slice2cpp Main.cpp Slice2Cpp.rc)

target_sources(slice2cpp 
   PRIVATE
      Gen.cpp
	   Gen.h
)

target_include_directories(slice2cpp
   PRIVATE
	  ${CMAKE_SOURCE_DIR}/cpp/include
	  ${CMAKE_SOURCE_DIR}/cpp/src
)

if(WIN32)
   if(MSVC)
      source_group("Resource Files" FILES ${CMAKE_CURRENT_SOURCE_DIR}/Slice2Cpp.rc)
      target_compile_definitions(slice2cpp PRIVATE 
         "ICE_BUILDING_SLICE_COMPILERS" 
         ${ICE_CPP98_COMPILE_DEFS}
      )

      target_compile_options(slice2cpp PRIVATE "/wd4250")
      
      set(rc_flags " /l 0x0409")
      set(CMAKE_RC_FLAGS ${rc_flags})
      set_target_properties(slice2cpp PROPERTIES LINK_FLAGS "wsetargv.obj")

      target_link_libraries(slice2cpp PRIVATE
         rpcrt4.lib
         advapi32.lib
         DbgHelp.lib
         Shlwapi.lib
      )
   endif()
endif()

target_link_libraries(slice2cpp PRIVATE
   mcpp
   slice
   iceutil   
)

install(TARGETS slice2cpp DESTINATION bin)
