if(NOT ${CMAKE_CURRENT_BINARY_DIR}/Glacier2)
	file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Glacier2)
endif()

set(GENERATED_DYNFILTERING_HEADERS ${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Test.h)
set(GENERATED_DYNFILTERING_SOURCES ${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Test.cpp)

if(BUILD_ICE_CPP98)
	set(DYNFILTER_DEPS 
		glacier2 
		ice
		icediscovery
		icelocatordiscovery
		icessl
		testcommon
	)
elseif(BUILD_ICE_CPP11)
	set(DYNFILTER_DEPS 
		glacier2++11 
		ice++11
		icediscovery++11
		icelocatordiscovery++11
		icessl++11
		testcommon++11
	)
elseif(BUILD_ICE_UWP)
	set(DYNFILTER_DEPS 
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
	${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Test.cpp 
	${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Test.h
)	
#function(CompileSlice slice2bin_params slice_include_paths ice_file output_dir output_file)
CompileSlice("${ICE_SLICE_PARAMS}"
	"${ICE_SLICE_DIRS}"
	${CMAKE_CURRENT_SOURCE_DIR}/Test.ice
	${CMAKE_CURRENT_BINARY_DIR}/Glacier2
	"${output_files}"
)

add_executable(glacier2dynfilterclient)

target_sources(glacier2dynfilterclient 
	PRIVATE 
		Client.cpp
		${GENERATED_DYNFILTERING_HEADERS}
		${GENERATED_DYNFILTERING_SOURCES}
)

target_include_directories(glacier2dynfilterclient
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Glacier2
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

if(BUILD_ICE_UWP)
	add_dependencies(glacier2dynfilterclient ${DYNFILTER_DEPS})
else()
	target_link_libraries(glacier2dynfilterclient PRIVATE ${DYNFILTER_DEPS})
endif()

target_compile_definitions(glacier2dynfilterclient PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Test.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_DYNFILTERING_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_DYNFILTERING_HEADERS}
	)

	target_compile_options(glacier2dynfilterclient
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET glacier2dynfilterclient PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET glacier2dynfilterclient PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS glacier2dynfilterclient DESTINATION tests/bin)

add_executable(glacier2dynfilterserver)

target_sources(glacier2dynfilterserver 
	PRIVATE 
		BackendI.cpp
		Server.cpp
		SessionI.cpp
		TestControllerI.cpp
		${GENERATED_DYNFILTERING_HEADERS}
		${GENERATED_DYNFILTERING_SOURCES}
)

target_include_directories(glacier2dynfilterserver
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Glacier2
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

if(BUILD_ICE_UWP)
	add_dependencies(glacier2dynfilterserver ${DYNFILTER_DEPS})
else()
	target_link_libraries(glacier2dynfilterserver PRIVATE ${DYNFILTER_DEPS})
endif()

target_compile_definitions(glacier2dynfilterserver PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Test.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_DYNFILTERING_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_DYNFILTERING_HEADERS}
	)

	target_compile_options(glacier2dynfilterserver
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET glacier2dynfilterserver PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET glacier2dynfilterserver PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS glacier2dynfilterserver DESTINATION tools/bin)
