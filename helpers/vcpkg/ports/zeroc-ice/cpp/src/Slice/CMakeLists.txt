if(CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
	string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
endif()

add_library(slice STATIC)

set_target_properties(slice 
	PROPERTIES 
		LANGUAGE CXX
		CXX_STANDARD 98
)

find_library(MCPP_LIB NAMES mcpp)

target_sources(slice
	PRIVATE
		Checksum.cpp
		Checksum.h
		CPlusPlusUtil.cpp
		CPlusPlusUtil.h
		FileTracker.cpp
		FileTracker.h
		Grammar.cpp
		Grammar.h
		Grammar.y
		GrammarUtil.h
		JavaUtil.cpp
		JavaUtil.h
		MD5.cpp
		MD5.h
		MD5I.cpp
		MD5I.h
		Parser.cpp
		Parser.h
		PHPUtil.cpp
		PHPUtil.h
		Preprocessor.cpp
		Preprocessor.h
		Python.cpp
		PythonUtil.cpp
		PythonUtil.h
		Ruby.cpp
		RubyUtil.cpp
		RubyUtil.h
		Scanner.cpp
		Scanner.l
		SliceUtil.cpp
		StringLiteralUtil.cpp
		Util.h
)

target_include_directories(slice 
	PRIVATE 
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

target_link_libraries(slice
	PRIVATE
		iceutil
		${MCPP_LIB}
)

target_compile_definitions(slice 
	PRIVATE  
		"ICE_BUILDING_SRC"
		"ICE_BUILDING_SLICE_COMPILERS"
)

if(NOT BUILD_ICE_UWP)
	target_compile_definitions(slice PRIVATE "ICE_STATIC_LIBS")
endif()

if(MSVC)
	target_compile_definitions(slice 
		PRIVATE  
			"_CONSOLE" 
			"WIN32_LEAN_AND_MEAN"
			"_SBCS"
			"_WIN32_WINNT=0x603"
	)
	
	if(BUILD_ICE_UWP)
		target_compile_definitions(slice PRIVATE "WINAPI_FAMILY=100")
		target_compile_options(slice PRIVATE "/WX")
	endif()

	target_compile_options(slice 
		PRIVATE 
			"/W4"
			"/wd4121"
			"/wd4250"
			"/wd4251"
			"/wd4275"
			"/wd4324"
			"/wd4127"
			"/wd4505"
			"/wd4512"
			"/wd4834"
			"/wd4098"
			"/MP"
			"/bigobj"
			"/wd4250"
	)
endif()

install(TARGETS slice DESTINATION lib)
