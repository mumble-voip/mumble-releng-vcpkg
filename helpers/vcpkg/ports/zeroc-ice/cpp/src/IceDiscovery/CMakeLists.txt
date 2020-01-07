if(NOT ${GENERATED_SLICES_DIR}/IceDiscovery)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceDiscovery)
endif()

set(ICEDISCOVERY_SLICES
	${SLICE_DIR}/IceDiscovery/IceDiscovery.ice
)

set(GENERATED_ICEDISCOVERY_HEADERS
	${GENERATED_SLICES_DIR}/IceDiscovery/IceDiscovery.h
)

set(GENERATED_ICEDISCOVERY_SOURCES
	${GENERATED_SLICES_DIR}/IceDiscovery/IceDiscovery.cpp
)

add_library(icediscovery)

target_sources(icediscovery
	PRIVATE
		LocatorI.cpp
		LocatorI.h
		LookupI.cpp
		LookupI.h
		PluginI.cpp
		PluginI.h
		${GENERATED_ICEDISCOVERY_HEADERS}
		${GENERATED_ICEDISCOVERY_SOURCES}
		${ICEDISCOVERY_SLICES}
)

target_include_directories(icediscovery
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src    
)

target_compile_definitions(icediscovery
	PRIVATE
		${ICE_COMPILE_DEFS}
		"ICEDISCOVERY_API_EXPORTS"
)

target_link_libraries(icediscovery
	PRIVATE
		ice
)

if(WIN32)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceDiscovery.rc
	)

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

	target_sources(icediscovery
		PRIVATE
			IceDiscovery.rc
	)

	target_compile_options(icediscovery 
		PRIVATE
			${ICE_WIN32_COMPILE_OPTIONS}   
	)

	target_compile_definitions(icediscovery
		PRIVATE
			${ICE_WIN32_COMPILE_DEFS}
	)
endif()

list(APPEND ICEDISCOVERY_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICEDISCOVERY_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceDiscovery")

foreach(slice ${ICEDISCOVERY_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${GENERATED_SLICES_DIR}/IceDiscovery/${slice_name}.cpp 
		${GENERATED_SLICES_DIR}/IceDiscovery/${slice_name}.h
	)
	#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice(slice2cpp
		"${ICEDISCOVERY_SLICE_PARAMS}"
		"${ICEDISCOVERY_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/IceDiscovery
		"${output_files}"
	)
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
	set_target_properties(icediscovery 
		PROPERTIES
			OUTPUT_NAME icediscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
	)
elseif(CMAKE_CXX_STANDARD EQUAL 98)
	set_target_properties(icediscovery 
		PROPERTIES
			OUTPUT_NAME icediscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
	)
endif()

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceDiscovery 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)
install(TARGETS icediscovery DESTINATION lib)
