add_library(iceutil STATIC)

set_property(TARGET iceutil PROPERTY CXX_STANDARD 98)

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
if(CMAKE_VS_PLATFORM_TOOLSET_VERSION MATCHES "v100" OR APPLE)
	target_sources(iceutil
		PRIVATE
			ConvertUTF.cpp
			ConvertUTF.h
			Unicode.cpp	
			Unicode.h	
	)
endif()

if(LINUX)
	target_sources(iceutil
		PRIVATE
			Unicode.cpp	
			Unicode.h
	)
endif()

target_include_directories(iceutil 
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
)

if(BUILD_ICE_UWP)
	target_compile_definitions(iceutil
		PRIVATE
			${ICE_UWP_COMPILE_DEFS}
			"ICE_BUILDING_SLICE_COMPILERS"
	)
else()
	target_compile_definitions(iceutil 
		PRIVATE
			${ICE_COMPILE_DEFS}
			"ICE_BUILDING_SLICE_COMPILERS"
			"ICE_API_EXPORTS"
	)
endif()

if(MSVC AND NOT WINDOWS_STORE)
	target_compile_options(iceutil 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	target_compile_definitions(iceutil
		PRIVATE
			${ICE_WIN32_COMPILE_DEFS}
	)
endif()

set_target_properties(iceutil 
	PROPERTIES
		OUTPUT_NAME IceUtil
)

install(TARGETS iceutil DESTINATION ${ICE_ARCHIVE_INSTALL_DIR})
