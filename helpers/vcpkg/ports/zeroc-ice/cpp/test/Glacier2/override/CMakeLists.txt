if(NOT ${CMAKE_CURRENT_BINARY_DIR}/Glacier2)
	file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Glacier2)
endif()

set(GENERATED_APPLICATION_HEADERS ${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Callback.h)
set(GENERATED_APPLICATION_SOURCES ${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Callback.cpp)

if(BUILD_ICE_CPP98)
	set(CLIENT_DEPS 
		glacier2 
		ice
		icediscovery
		icelocatordiscovery
		icessl
		testcommon
	)
elseif(BUILD_ICE_CPP11)
	set(CLIENT_DEPS 
		glacier2++11 
		ice++11
		icediscovery++11
		icelocatordiscovery++11
		icessl++11
		testcommon++11
	)
elseif(BUILD_ICE_UWP)
	set(CLIENT_DEPS 
		glacier2uwp++11 
		iceuwp++11
		icediscoveryuwp++11
		icelocatordiscoveryuwp++11
		icessluwp++11
		testcommonuwp++11
	)
endif()

list(APPEND ICE_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICE_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "Glacier2")

set(output_files 
	${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Callback.cpp 
	${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Callback.h
)	
#function(CompileSlice slice2bin_params slice_include_paths ice_file output_dir output_file)
CompileSlice("${ICE_SLICE_PARAMS}"
	"${ICE_SLICE_DIRS}"
	${CMAKE_CURRENT_SOURCE_DIR}/Callback.ice
	${CMAKE_CURRENT_BINARY_DIR}/Glacier2
	"${output_files}"
)

add_executable(glacier2overrideclient)

target_sources(glacier2overrideclient 
	PRIVATE 
		Client.cpp
		CallbackI.cpp
		Callback.ice
		${GENERATED_APPLICATION_HEADERS}
		${GENERATED_APPLICATION_SOURCES}
)

target_include_directories(glacier2overrideclient
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Glacier2
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

target_link_libraries(glacier2overrideclient PRIVATE ${CLIENT_DEPS})

target_compile_definitions(glacier2overrideclient PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Callback.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_APPLICATION_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_APPLICATION_HEADERS}
	)

	target_compile_options(glacier2overrideclient
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET glacier2overrideclient PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET glacier2overrideclient PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS glacier2overrideclient DESTINATION tests/bin)

if(BUILD_ICE_CPP98)
	set(SERVER_DEPS 
		glacier2
		ice
		icediscovery
		icelocatordiscovery
		icessl
		testcommon
	)
elseif(BUILD_ICE_CPP11)
	set(SERVER_DEPS 
		glacier2++11
		ice++11
		icediscovery++11
		icelocatordiscovery++11
		icessl++11
		testcommon++11
	)
elseif(BUILD_ICE_UWP)
	set(SERVER_DEPS 
		glacier2uwp++11
		iceuwp++11
		icediscoveryuwp++11
		icelocatordiscoveryuwp++11
		icessluwp++11
		testcommonuwp++11
	)
endif()

add_executable(glacier2overrideserver)

target_sources(glacier2overrideserver 
	PRIVATE 
		Server.cpp
		CallbackI.cpp
		Callback.ice
		${GENERATED_APPLICATION_HEADERS}
		${GENERATED_APPLICATION_SOURCES}
)

target_include_directories(glacier2overrideserver
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Glacier2
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

target_link_libraries(glacier2overrideserver PRIVATE ${SERVER_DEPS})

target_compile_definitions(glacier2overrideserver PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Callback.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_APPLICATION_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_APPLICATION_HEADERS}
	)

	target_compile_options(glacier2overrideserver
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET glacier2overrideserver PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET glacier2overrideserver PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS glacier2overrideserver DESTINATION tools/bin)

