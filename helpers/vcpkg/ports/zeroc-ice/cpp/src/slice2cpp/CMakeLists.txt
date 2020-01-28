if(CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
	string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
endif()

add_executable(slice2cpp)

set_property(TARGET slice2cpp PROPERTY CXX_STANDARD 98)

find_library(MCPP_LIB NAMES mcpp)

target_sources(slice2cpp 
	PRIVATE
		Gen.cpp
		Gen.h
		Main.cpp
)

target_include_directories(slice2cpp
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(slice2cpp 
	PRIVATE 
		"ICE_BUILDING_SRC"
		"ICE_BUILDING_SLICE_COMPILERS"
)

if(NOT BUILD_ICE_UWP)
	target_compile_definitions(slice2cpp PRIVATE "ICE_STATIC_LIBS")
endif()

target_link_libraries(slice2cpp 
	PRIVATE
		${MCPP_LIB}
		Threads::Threads
		slice 
)

if(MSVC)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files" 
		FILES Slice2Cpp.rc
	)

	target_sources(slice2cpp
		PRIVATE
			Slice2Cpp.rc
	)

	target_compile_definitions(slice2cpp 
		PRIVATE 
			"_CONSOLE" 
			"WIN32_LEAN_AND_MEAN"
			"_SBCS"
			"_WIN32_WINNT=0x603"
	)

	if(BUILD_ICE_UWP)
		target_compile_definitions(slice2cpp PRIVATE "WINAPI_FAMILY=100")
		target_compile_options(slice2cpp PRIVATE "/WX")
	endif()

	target_compile_options(slice2cpp 
		PRIVATE 
			"/wd4121"
			"/wd4250"
			"/wd4251"
			"/wd4275"
			"/wd4324"
			"/wd4127"
			"/wd4505"
			"/wd4512"
			"/wd4834"
			"/MP"
			"/bigobj"
			"/wd4250"
	)

	set_property(TARGET slice2cpp PROPERTY LINK_FLAGS "wsetargv.obj")

	target_link_libraries(slice2cpp PRIVATE
		rpcrt4.lib
		advapi32.lib
		DbgHelp.lib
		Shlwapi.lib
	)
endif()

install(TARGETS slice2cpp DESTINATION bin)
