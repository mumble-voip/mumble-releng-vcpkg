# define c++ compiler options and preprocessor definitions for all OS types
set(ICE_COMPILE_DEFS "ICE_BUILDING_SRC")
set(STATIC_ICE_COMPILE_DEFS ${ICE_COMPILE_DEFS} "ICE_STATIC_LIBS")

if(BUILD_ICE_CPP11)
	set(ICE_COMPILE_DEFS ${ICE_COMPILE_DEFS} "ICE_CPP11_MAPPING")
	if(NOT BUILD_SHARED_LIBS)
		set(ICE_COMPILE_DEFS ${STATIC_ICE_COMPILE_DEFS} "ICE_CPP11_MAPPING")
	endif()
elseif(BUILD_ICE_CPP98)
	if(NOT BUILD_SHARED_LIBS)
		set(ICE_COMPILE_DEFS ${STATIC_ICE_COMPILE_DEFS})
	endif()
elseif(BUILD_ICE_UWP)
	set(ICE_COMPILE_DEFS ${STATIC_ICE_COMPILE_DEFS} "ICE_CPP11_MAPPING")
endif()


if(NOT BUILD_SHARED_LIBS)
	set(ICE_COMPILE_DEFS ${STATIC_ICE_COMPILE_DEFS})
	
endif()

list(APPEND COMPILE_SLICES_CPP_PARAMETERS "--include-dir")

if(MSVC)
	string(REGEX REPLACE "/INCREMENTAL *" "/INCREMENTAL:NO " 
		CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}"
	)

	string(REGEX REPLACE "/INCREMENTAL *" "/INCREMENTAL:NO " 
		CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}"
	)

	string(REGEX REPLACE "/OPT:LBR *" "/OPT:NOLBR " 
		CMAKE_EXE_LINKER_FLAGS_DEBUG "${CMAKE_EXE_LINKER_FLAGS_DEBUG}"
	)

	string(REGEX REPLACE "/OPT:LBR *" "/OPT:NOLBR " 
		CMAKE_SHARED_LINKER_FLAGS_DEBUG "${CMAKE_SHARED_LINKER_FLAGS_DEBUG}"
	)
	
	if(WIN32)
		set(ICE_COMPILE_DEFS
			${ICE_COMPILE_DEFS}
			"_CONSOLE" 
			"WIN32_LEAN_AND_MEAN"
			"_SBCS"
			"_WIN32_WINNT=0x603"
		)
	elseif(WINDOWS_STORE)
		set(ICE_COMPILE_DEFS
			${ICE_COMPILE_DEFS}
			"WINAPI_FAMILY=2"
			"_UNICODE"
			"UNICODE"
			"WIN32_LEAN_AND_MEAN"
		)
	endif()

	set(ICE_MSVC_COMPILE_OPTIONS
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
		"/MP"
		"/bigobj"
	)

	if(BUILD_ICE_UWP)
		set(ICE_MSVC_COMPILE_OPTIONS
			${ICE_MSVC_COMPILE_OPTIONS}
			"/wd4264"
			"/wd4221"
		)
	endif()

	set(ICE_MSVC_APP_LINK_OPTIONS
		"wsetargv.obj"
	)

	set(ICE_MSVC_DLL_LINK_OPTIONS
		"/ERRORREPORT:QUEUE 
		/NOLOGO 
		/MANIFEST 
		/MANIFESTUAC:\"level='asInvoker' uiAccess='false'\" 
		/NXCOMPAT 
		/DYNAMICBASE 
		/TLBID:1"
	)	
elseif(APPLE)
	# TODO - add ICE_COMPILE_DEFS
elseif(UNIX OR LINUX)
	# TODO - ICE_COMPILE_DEFS
endif()
