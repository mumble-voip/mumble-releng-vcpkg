if(MSVC)
	if(CMAKE_CXX_FLAGS MATCHES "/W[0-4]")
		string(REGEX REPLACE "/W[0-4]" "/W4" CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}")
	endif()
endif()

add_library(iceutil STATIC)

set_target_properties(iceutil 
	PROPERTIES 
		LANGUAGE CXX
		CXX_STANDARD 98
)

target_sources(iceutil 
	PRIVATE
		ConsoleUtil.cpp
		CtrlCHandler.cpp
		FileUtil.cpp
		InputUtil.cpp
		MutexProtocol.cpp
		Options.cpp
		OutputUtil.cpp
		Random.cpp
		RecMutex.cpp
		Shared.cpp
		StringConverter.cpp
		StringUtil.cpp
		ThreadException.cpp
		Time.cpp
		UtilException.cpp
		UUID.cpp
)

# handle win specific UTF limitations
if(CMAKE_VS_PLATFORM_TOOLSET_VERSION MATCHES "v100" OR UNIX)
	target_sources(iceutil
		PRIVATE
			ConvertUTF.cpp
			ConvertUTF.h
			Unicode.cpp	
			Unicode.h	
	)
endif()

target_include_directories(iceutil 
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(iceutil
	PRIVATE
		"ICE_BUILDING_SRC"
		"ICE_BUILDING_SLICE_COMPILERS"
)

target_link_libraries(iceutil PRIVATE Threads::Threads)

if(NOT BUILD_SHARED_LIBS)
	target_compile_definitions(iceutil 
		PRIVATE
			"ICE_STATIC_LIBS"
	)
else()
	target_compile_definitions(iceutil 
		PRIVATE
			"ICE_API_EXPORTS"
	)
endif()

if(MSVC)
	target_compile_definitions(iceutil
		PRIVATE
			"_CONSOLE" 
			"WIN32_LEAN_AND_MEAN"
			"_SBCS"
			"_WIN32_WINNT=0x603"
	)
	
	if(BUILD_ICE_UWP)
		target_compile_definitions(iceutil PRIVATE "WINAPI_FAMILY=100")
		target_compile_options(iceutil PRIVATE "/WX")
	endif()

	target_compile_options(iceutil
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
	)
endif()

install(TARGETS iceutil DESTINATION lib)

if(BUILD_ICE_CPP11)
	add_library(iceutil++11 STATIC)
	
	set_target_properties(iceutil++11 
		PROPERTIES
			LANGUAGE CXX
			CXX_STANDARD 11
			OUTPUT_NAME iceutil++11
	)

	target_sources(iceutil++11 
		PRIVATE
			ConsoleUtil.cpp
			CtrlCHandler.cpp
			FileUtil.cpp
			InputUtil.cpp
			MutexProtocol.cpp
			Options.cpp
			OutputUtil.cpp
			Random.cpp
			RecMutex.cpp
			Shared.cpp
			StringConverter.cpp
			StringUtil.cpp
			ThreadException.cpp
			Time.cpp
			UtilException.cpp
			UUID.cpp
	)

	# handle win specific UTF limitations
	if(CMAKE_VS_PLATFORM_TOOLSET_VERSION MATCHES "v100" OR UNIX)
		target_sources(iceutil++11
			PRIVATE
				ConvertUTF.cpp
				ConvertUTF.h
				Unicode.cpp	
				Unicode.h	
		)
	endif()

	target_include_directories(iceutil++11 
		PRIVATE
			${PROJECT_SOURCE_DIR}/cpp/include
			${PROJECT_SOURCE_DIR}/cpp/src
	)

	target_compile_definitions(iceutil++11 
		PRIVATE
			${ICE_COMPILE_DEFS}
			"ICE_API_EXPORTS"
	)

	target_link_libraries(iceutil++11 PRIVATE Threads::Threads)

	if(MSVC)
		target_compile_options(iceutil++11 
			PRIVATE
				${ICE_MSVC_COMPILE_OPTIONS}
		)
	endif()

	install(TARGETS iceutil++11 DESTINATION lib)
endif()
