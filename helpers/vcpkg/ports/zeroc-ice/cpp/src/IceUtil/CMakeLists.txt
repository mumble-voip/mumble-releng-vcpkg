add_library(iceutil STATIC)

if(BUILD_ICE_CPP98)
	set_target_properties(iceutil 
		PROPERTIES
			LANGUAGE CXX
			CXX_STANDARD 98
			OUTPUT_NAME iceutil
	)
elseif(BUILD_ICE_CPP11)
	set_target_properties(iceutil 
		PROPERTIES
			LANGUAGE CXX
			CXX_STANDARD 11
			OUTPUT_NAME iceutil
	)
endif()

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
		${ICE_COMPILE_DEFS}
)

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

if(NOT BUILD_ICE_UWP)
	target_link_libraries(iceutil PRIVATE Threads::Threads)
else()
	set_property(TARGET iceutil PROPERTY ${ICE_UWP_LINK_OPTIONS})
endif()

if(MSVC)
	target_compile_options(iceutil 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)
endif()

install(TARGETS iceutil DESTINATION lib)
