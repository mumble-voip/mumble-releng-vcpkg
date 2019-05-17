#cmake_minimum_required(VERSION 3.1.0)

project(Slice2CPP)


add_executable(slice2cpp Main.cpp)

target_sources(slice2cpp 
   PRIVATE
      Gen.cpp
	  Gen.h
	  Slice2Cpp.rc
)

target_include_directories(slice2cpp
   PRIVATE
	  "${CMAKE_SOURCE_DIR}/include"
	  "${CMAKE_SOURCE_DIR}/src"
)

add_dependencies(slice2cpp iceutil slice)

target_link_libraries(slice2cpp 
   mcpp
   iceutil
   slice
)

if(WIN32)
   target_compile_definitions(slice2cpp PRIVATE "ICE_BUILDING_SLICE_COMPILERS" "ICE_STATIC_LIBS")
   target_link_libraries(slice2cpp 
	     "rpcrt4.lib"
		 "advapi32.lib"
		 "DbgHelp.lib"
		 "Shlwapi.lib"
   )
endif()

install(TARGETS slice2cpp DESTINATION bin)