if(NOT WINDOWS_STORE)
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
	if(CMAKE_VS_PLATFORM_TOOLSET_VERSION MATCHES "v100")
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
				Unicode.h
				Unicode.cpp
		)
	endif()

	if(APPLE)
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
	)

	target_compile_definitions(iceutil 
		PRIVATE
			${ICE_COMPILE_DEFS}
			"ICE_BUILDING_SLICE_COMPILERS"
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
endif()
