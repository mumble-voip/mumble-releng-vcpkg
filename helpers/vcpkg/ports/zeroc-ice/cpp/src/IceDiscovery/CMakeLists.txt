if(NOT ${GENERATED_SLICES_DIR}/IceDiscovery)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceDiscovery)
endif()

set(GENERATED_ICEDISCOVERY_HEADERS
	${GENERATED_SLICES_DIR}/IceDiscovery/IceDiscovery.h
)

set(GENERATED_ICEDISCOVERY_SOURCES
	${GENERATED_SLICES_DIR}/IceDiscovery/IceDiscovery.cpp
)

set(ICEDISCOVERY_SOURCES
	LocatorI.cpp
	LocatorI.h
	LookupI.cpp
	LookupI.h
	PluginI.cpp
	PluginI.h
)

list(APPEND ICEDISCOVERY_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICEDISCOVERY_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceDiscovery")

foreach(slice ${ICEDISCOVERY_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${GENERATED_SLICES_DIR}/IceDiscovery/${slice_name}.cpp 
		${GENERATED_SLICES_DIR}/IceDiscovery/${slice_name}.h
	)
	#function(CompileSlice slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice("${ICEDISCOVERY_SLICE_PARAMS}"
		"${ICEDISCOVERY_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/IceDiscovery
		"${output_files}"
	)
endforeach()

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceDiscovery 
	DESTINATION ${GENERATED_H_INSTALL_DIR}
	FILES_MATCHING PATTERN "*.h"
)

if(BUILD_ICE_CPP98)
	set(ICEDISCOVERY_TARGET icediscovery)

	add_library(${ICEDISCOVERY_TARGET})

	set_target_properties(${ICEDISCOVERY_TARGET} 
		PROPERTIES
			OUTPUT_NAME IceDiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
			CXX_STANDARD 98
	)

	target_link_libraries(${ICEDISCOVERY_TARGET} PRIVATE ice)
elseif(BUILD_ICE_CPP11)
	set(ICEDISCOVERY_TARGET icediscovery++11)

	add_library(${ICEDISCOVERY_TARGET})

	set_target_properties(${ICEDISCOVERY_TARGET} 
		PROPERTIES
			OUTPUT_NAME IceDiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			CXX_STANDARD 11
	)

	target_link_libraries(${ICEDISCOVERY_TARGET} PRIVATE ice++11)
elseif(BUILD_ICE_UWP)
	set(ICEDISCOVERY_TARGET icediscoveryuwp++11)

	add_library(${ICEDISCOVERY_TARGET} STATIC)
	
	set_target_properties(${ICEDISCOVERY_TARGET} 
		PROPERTIES
			OUTPUT_NAME IceDiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			CXX_STANDARD 11
			LINK_FLAGS ${ICE_UWP_LINK_OPTIONS}
	)

	add_dependencies(${ICEDISCOVERY_TARGET} iceuwp++11)
endif()

target_sources(${ICEDISCOVERY_TARGET}
	PRIVATE
		${ICEDISCOVERY_SOURCES}
		${GENERATED_ICEDISCOVERY_HEADERS}
		${GENERATED_ICEDISCOVERY_SOURCES}
		${ICEDISCOVERY_SLICES}
)

target_include_directories(${ICEDISCOVERY_TARGET}
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src    
)

if(NOT BUILD_ICE_UWP)
	target_compile_definitions(${ICEDISCOVERY_TARGET}
		PRIVATE
			${ICE_COMPILE_DEFS}
			"ICE_DISCOVERY_API_EXPORTS"
	)
else()
	target_compile_definitions(${ICEDISCOVERY_TARGET}
		PRIVATE
			${ICE_COMPILE_DEFS}
	)
endif()

if(MSVC)
	if(NOT BUILD_ICE_UWP)
		source_group(
			TREE ${CMAKE_CURRENT_SOURCE_DIR}
			PREFIX "Resource Files"
			FILES
				IceDiscovery.rc
		)

		target_sources(${ICEDISCOVERY_TARGET}
			PRIVATE
				IceDiscovery.rc
		)
	endif()

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceDiscovery
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_ICEDISCOVERY_HEADERS}
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceDiscovery
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_ICEDISCOVERY_SOURCES}
	)

	source_group(
		TREE ${SLICE_DIR}/IceDiscovery
		PREFIX "Slice Files"
		FILES
			${ICEDISCOVERY_SLICES}
	)

	set_property(TARGET ${ICEDISCOVERY_TARGET} PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})

	target_compile_options(${ICEDISCOVERY_TARGET} 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}   
	)
endif()

if(BUILD_SHARED_LIBS AND NOT BUILD_ICE_UWP)
	install(TARGETS ${ICEDISCOVERY_TARGET} DESTINATION bin)
else()
	install(TARGETS ${ICEDISCOVERY_TARGET} DESTINATION lib)
endif()
