if(NOT ${GENERATED_SLICES_DIR}/IceLocatorDiscovery)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceLocatorDiscovery)
endif()

set(ICELOCATORDISCOVERY_SLICES
	${SLICE_DIR}/IceLocatorDiscovery/IceLocatorDiscovery.ice
)

set(GENERATED_ICELOCATORDISCOVERY_HEADERS
	${GENERATED_SLICES_DIR}/IceLocatorDiscovery/IceLocatorDiscovery.h
)

set(GENERATED_ICELOCATORDISCOVERY_SOURCES
	${GENERATED_SLICES_DIR}/IceLocatorDiscovery/IceLocatorDiscovery.cpp
)

add_library(icelocatordiscovery)

target_sources(icelocatordiscovery
	PRIVATE
		Plugin.h
		PluginI.cpp
		${GENERATED_ICELOCATORDISCOVERY_HEADERS}
		${GENERATED_ICELOCATORDISCOVERY_SOURCES}
		${ICELOCATORDISCOVERY_SLICES}
)

target_include_directories(icelocatordiscovery
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src    
)

target_compile_definitions(icelocatordiscovery
	PRIVATE
		${ICE_COMPILE_DEFS}
		"ICE_LOCATOR_DISCOVERY_API_EXPORTS"
)

target_link_libraries(icelocatordiscovery
	PRIVATE
		ice
)

if(MSVC)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceLocatorDiscovery.rc
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceLocatorDiscovery
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_ICELOCATORDISCOVERY_HEADERS}
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceLocatorDiscovery
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_ICELOCATORDISCOVERY_SOURCES}
	)

	source_group(
		TREE ${SLICE_DIR}/IceLocatorDiscovery
		PREFIX "Slice Files"
		FILES
			${ICELOCATORDISCOVERY_SLICES}
	)

	target_sources(icelocatordiscovery
		PRIVATE
			IceLocatorDiscovery.rc
	)

	target_compile_options(icelocatordiscovery 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}   
	)

	target_compile_definitions(icelocatordiscovery
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)
endif()

list(APPEND ICELOCATORDISCOVERY_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICELOCATORDISCOVERY_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceLocatorDiscovery")

foreach(slice ${ICELOCATORDISCOVERY_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${GENERATED_SLICES_DIR}/IceLocatorDiscovery/${slice_name}.cpp
		${GENERATED_SLICES_DIR}/IceLocatorDiscovery/${slice_name}.h
	)
	#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice(slice2cpp
		"${ICELOCATORDISCOVERY_SLICE_PARAMS}"
		"${ICELOCATORDISCOVERY_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/IceLocatorDiscovery
		"${output_files}"
	)
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
	set_target_properties(icelocatordiscovery 
		PROPERTIES
			OUTPUT_NAME IceLocatorDiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
	)
elseif(CMAKE_CXX_STANDARD EQUAL 98)
	set_target_properties(icelocatordiscovery 
		PROPERTIES
			OUTPUT_NAME IceLocatorDiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
	)
endif()

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceLocatorDiscovery 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)
install(TARGETS icelocatordiscovery DESTINATION lib)
