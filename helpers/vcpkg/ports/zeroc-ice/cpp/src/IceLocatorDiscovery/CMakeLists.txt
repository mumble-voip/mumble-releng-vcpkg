if(NOT ${GENERATED_SLICES_DIR}/IceLocatorDiscovery)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceLocatorDiscovery)
endif()

set(GENERATED_ICELOCATORDISCOVERY_HEADERS
	${GENERATED_SLICES_DIR}/IceLocatorDiscovery/IceLocatorDiscovery.h
)

set(GENERATED_ICELOCATORDISCOVERY_SOURCES
	${GENERATED_SLICES_DIR}/IceLocatorDiscovery/IceLocatorDiscovery.cpp
)

set(ICELOCATORDISCOVERY_SOURCES
	Plugin.h
	PluginI.cpp
)

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

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceLocatorDiscovery 
	DESTINATION ${GENERATED_H_INSTALL_DIR}
	FILES_MATCHING PATTERN "*.h"
)

if(BUILD_ICE_CPP98)
	set(ICELOCATOR_DISCOVERY_TARGET icelocatordiscovery)
	add_library(${ICELOCATOR_DISCOVERY_TARGET})
	set_target_properties(${ICELOCATOR_DISCOVERY_TARGET} 
		PROPERTIES
			OUTPUT_NAME IceLocatorDiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
			LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS}
			CXX_STANDARD 98
	)
elseif(BUILD_ICE_CPP11)
	set(ICELOCATOR_DISCOVERY_TARGET icelocatordiscovery++11)
	add_library(${ICELOCATOR_DISCOVERY_TARGET})
	set_target_properties(${ICELOCATOR_DISCOVERY_TARGET} 
		PROPERTIES
			OUTPUT_NAME IceLocatorDiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS}
			CXX_STANDARD 11
	)
elseif(BUILD_ICE_UWP)
	set(ICELOCATOR_DISCOVERY_TARGET icelocatordiscoveryuwp++11)
	add_library(${ICELOCATOR_DISCOVERY_TARGET} STATIC)
	set_target_properties(${ICELOCATOR_DISCOVERY_TARGET} 
		PROPERTIES
			OUTPUT_NAME IceLocatorDiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS}
			CXX_STANDARD 11
	)
endif()

target_sources(${ICELOCATOR_DISCOVERY_TARGET}
	PRIVATE
		${ICELOCATORDISCOVERY_SOURCES}
		${GENERATED_ICELOCATORDISCOVERY_HEADERS}
		${GENERATED_ICELOCATORDISCOVERY_SOURCES}
		${ICELOCATORDISCOVERY_SLICES}
)

target_include_directories(${ICELOCATOR_DISCOVERY_TARGET}
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src    
)

target_compile_definitions(${ICELOCATOR_DISCOVERY_TARGET}
	PRIVATE
		${ICE_COMPILE_DEFS}
		"ICE_LOCATOR_DISCOVERY_API_EXPORTS"
)

if(BUILD_ICE_CPP98)
	target_link_libraries(${ICELOCATOR_DISCOVERY_TARGET}
		PRIVATE
			ice
	)
elseif(BUILD_ICE_CPP11)
	target_link_libraries(${ICELOCATOR_DISCOVERY_TARGET}
		PRIVATE
			ice++11
	)
elseif(BUILD_ICE_UWP)
	add_dependencies(${ICELOCATOR_DISCOVERY_TARGET} iceuwp++11)
endif()

if(MSVC)
	if(NOT BUILD_ICE_UWP)
		source_group(
			TREE ${CMAKE_CURRENT_SOURCE_DIR}
			PREFIX "Resource Files"
			FILES
				IceLocatorDiscovery.rc
		)
		
		target_sources(${ICELOCATOR_DISCOVERY_TARGET}
			PRIVATE
				IceLocatorDiscovery.rc
		)
	endif()

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

	target_compile_options(${ICELOCATOR_DISCOVERY_TARGET} 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}   
	)
endif()

install(TARGETS ${ICELOCATOR_DISCOVERY_TARGET} 
	RUNTIME DESTINATION ${ICE_RUNTIME_INSTALL_DIR}
	LIBRARY DESTINATION ${ICE_LIBRARY_INSTALL_DIR}
	ARCHIVE DESTINATION ${ICE_ARCHIVE_INSTALL_DIR}
)
