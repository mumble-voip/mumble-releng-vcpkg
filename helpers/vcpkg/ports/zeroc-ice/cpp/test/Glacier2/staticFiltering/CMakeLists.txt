if(NOT ${CMAKE_CURRENT_BINARY_DIR}/Glacier2)
	file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Glacier2)
endif()

set(GENERATED_STATICFILTER_HEADERS ${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Backend.h)
set(GENERATED_STATICFILTER_SOURCES ${CMAKE_CURRENT_BINARY_DIR}/Glacier2/Backend.cpp)

if(BUILD_ICE_CPP98)
	set(STATICFILTER_DEPS 
		glacier2 
		ice
		icediscovery
		icelocatordiscovery
		icessl
		testcommon
	)
elseif(BUILD_ICE_CPP11)
	set(STATICFILTER_DEPS 
		glacier2++11 
		ice++11
		icediscovery++11
		icelocatordiscovery++11
		icessl++11
		testcommon++11
	)
elseif(BUILD_ICE_UWP)
	set(STATICFILTER_DEPS 
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

add_executable(glacier2staticfilterclient)

target_sources(glacier2staticfilterclient 
	PRIVATE 
		Client.cpp
		BackendI.cpp
		${GENERATED_STATICFILTER_HEADERS}
		${GENERATED_STATICFILTER_SOURCES}
)

target_include_directories(glacier2staticfilterclient
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Glacier2
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

if(BUILD_ICE_UWP)
	add_dependencies(glacier2staticfilterclient ${STATICFILTER_DEPS})
else()
	target_link_libraries(glacier2staticfilterclient PRIVATE ${STATICFILTER_DEPS})
endif()


target_compile_definitions(glacier2staticfilterclient PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Backend.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_STATICFILTER_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_STATICFILTER_HEADERS}
	)

	target_compile_options(glacier2staticfilterclient
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET glacier2staticfilterclient PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET glacier2staticfilterclient PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS glacier2staticfilterclient DESTINATION tests/bin)

add_executable(glacier2staticfilterserver)

target_sources(glacier2staticfilterserver 
	PRIVATE 
		Server.cpp
		BackendI.cpp
		${GENERATED_STATICFILTER_HEADERS}
		${GENERATED_STATICFILTER_SOURCES}
)

target_include_directories(glacier2staticfilterserver
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Glacier2
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

if(BUILD_ICE_UWP)
	add_dependencies(glacier2staticfilterserver ${STATICFILTER_DEPS})
else()
	target_link_libraries(glacier2staticfilterserver PRIVATE ${STATICFILTER_DEPS})
endif()

target_compile_definitions(glacier2staticfilterserver PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Backend.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_STATICFILTER_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_STATICFILTER_HEADERS}
	)

	target_compile_options(glacier2staticfilterserver
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET glacier2staticfilterserver PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET glacier2staticfilterserver PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS glacier2staticfilterserver DESTINATION tools/bin)
