
set(rc_flags " /l 0x0409")
set(CMAKE_RC_FLAGS ${rc_flags})
add_executable(slice2cpp Main.cpp Slice2Cpp.rc)

target_sources(slice2cpp 
   PRIVATE
      Gen.cpp
	  Gen.h
)

target_include_directories(slice2cpp
   PRIVATE
	  "${CMAKE_SOURCE_DIR}/cpp/include"
	  "${CMAKE_SOURCE_DIR}/cpp/src"
)

add_dependencies(slice2cpp 
   mcpp
   iceutil 
   slice
)

target_link_libraries(slice2cpp 
   mcpp
   iceutil
   slice
)

if(WIN32)
   target_compile_definitions(slice2cpp PRIVATE 
      "ICE_BUILDING_SLICE_COMPILERS" 
	  "ICE_STATIC_LIBS"
   )
   
   target_link_libraries(slice2cpp 
	     "rpcrt4.lib"
		 "advapi32.lib"
		 "DbgHelp.lib"
		 "Shlwapi.lib"
   )
   set_target_properties(slice2cpp PROPERTIES LINK_FLAGS "wsetargv.obj")
endif()

install(TARGETS slice2cpp DESTINATION bin)