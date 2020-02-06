if(NOT ${CMAKE_CURRENT_BINARY_DIR}/Glacier2)
	file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Glacier2)
endif()

set(GENERATED_ATTACK_HEADERS ${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Backend.h)
set(GENERATED_ATTACK_SOURCES ${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Backend.cpp)

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
	${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Backend.cpp 
	${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Backend.h
)	
#function(CompileSlice slice2bin_params slice_include_paths ice_file output_dir output_file)
CompileSlice("${ICE_SLICE_PARAMS}"
	"${ICE_SLICE_DIRS}"
	${CMAKE_CURRENT_SOURCE_DIR}/Backend.ice
	${CMAKE_CURRENT_BINARY_DIR}/Glacier2
	"${output_files}"
)

add_executable(glacier2attackclient)

target_sources(glacier2attackclient 
	PRIVATE 
		Client.cpp
		BackendI.cpp
		Backend.ice
		${GENERATED_ATTACK_HEADERS}
		${GENERATED_ATTACK_SOURCES}
)

target_include_directories(glacier2attackclient
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Glacier2
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

target_link_libraries(glacier2attackclient PRIVATE ${CLIENT_DEPS})

target_compile_definitions(glacier2attackclient PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Backend.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_ATTACK_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_ATTACK_HEADERS}
	)

	target_compile_options(glacier2attackclient
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET glacier2attackclient PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET glacier2attackclient PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS glacier2attackclient DESTINATION tests/bin)

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

add_executable(glacier2attackserver)

target_sources(glacier2attackserver 
	PRIVATE 
		Server.cpp
		BackendI.cpp
		Backend.ice
		${GENERATED_ATTACK_HEADERS}
		${GENERATED_ATTACK_SOURCES}
)

target_include_directories(glacier2attackserver
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Glacier2
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

target_link_libraries(glacier2attackserver PRIVATE ${SERVER_DEPS})

target_compile_definitions(glacier2attackserver PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Backend.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_ATTACK_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_ATTACK_HEADERS}
	)

	target_compile_options(glacier2attackserver
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET glacier2attackserver PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET glacier2attackserver PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS glacier2attackserver DESTINATION tools/bin)
