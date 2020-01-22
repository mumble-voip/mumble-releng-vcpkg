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

target_compile_definitions(iceutil 
	PRIVATE
		${ICE_COMPILE_DEFS}
		"ICE_BUILDING_SLICE_COMPILERS"
		"ICE_API_EXPORTS"
)

if(MSVC)
	target_compile_options(iceutil 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	target_compile_definitions(iceutil
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)
endif()

set_target_properties(iceutil 
	PROPERTIES
		OUTPUT_NAME IceUtil
)

install(TARGETS iceutil DESTINATION lib)

add_library(iceutil++11 STATIC)

set_property(TARGET iceutil++11 PROPERTY CXX_STANDARD 11)

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
if(CMAKE_VS_PLATFORM_TOOLSET_VERSION MATCHES "v100" OR APPLE)
	target_sources(iceutil++11
		PRIVATE
			ConvertUTF.cpp
			ConvertUTF.h
			Unicode.cpp	
			Unicode.h	
	)
endif()

if(LINUX)
	target_sources(iceutil++11
		PRIVATE
			Unicode.h
			Unicode.cpp
	)
endif()

target_include_directories(iceutil++11 
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
)

target_compile_definitions(iceutil++11 
	PRIVATE
		${ICE_COMPILE_DEFS}
		"ICE_CPP11_MAPPING"
		"ICE_API_EXPORTS"
)

if(MSVC)
	target_compile_options(iceutil++11 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	target_compile_definitions(iceutil++11
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)
endif()

set_target_properties(iceutil++11 
	PROPERTIES
		OUTPUT_NAME iceutil++11
)

install(TARGETS iceutil++11 DESTINATION lib)
