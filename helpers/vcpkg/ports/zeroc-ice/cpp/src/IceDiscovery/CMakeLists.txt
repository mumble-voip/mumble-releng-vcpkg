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

set(ICEDISCOVERY_SOURCES
	LocatorI.cpp
	LocatorI.h
	LookupI.cpp
	LookupI.h
	PluginI.cpp
	PluginI.h
)

if(NOT WINDOWS_STORE)
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

	install(DIRECTORY ${GENERATED_SLICES_DIR}/IceDiscovery 
		DESTINATION include
		FILES_MATCHING PATTERN "*.h"
	)

	add_library(icediscovery)

	set_property(TARGET icediscovery PROPERTY CXX_STANDARD 98)

	target_sources(icediscovery
		PRIVATE
			${ICEDISCOVERY_SOURCES}
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
			"ICE_DISCOVERY_API_EXPORTS"
	)

	target_link_libraries(icediscovery
		PRIVATE
			ice
	)

	if(MSVC)
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
				${ICE_MSVC_COMPILE_OPTIONS}   
		)

		target_compile_definitions(icediscovery
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
		)
	endif()

	set_target_properties(icediscovery 
		PROPERTIES
			OUTPUT_NAME IceDiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
			LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS}
	)

	install(TARGETS icediscovery DESTINATION lib)

	add_library(icediscovery++11)

	set_property(TARGET icediscovery++11 PROPERTY CXX_STANDARD 11)

	target_sources(icediscovery++11
		PRIVATE
			${ICEDISCOVERY_SOURCES}
			${GENERATED_ICEDISCOVERY_HEADERS}
			${GENERATED_ICEDISCOVERY_SOURCES}
			${ICEDISCOVERY_SLICES}
	)

	target_include_directories(icediscovery++11
		PRIVATE 
			${GENERATED_SLICES_DIR}
			${PROJECT_SOURCE_DIR}/cpp/include
			${PROJECT_SOURCE_DIR}/cpp/src    
	)

	target_compile_definitions(icediscovery++11
		PRIVATE
			${ICE_CPP11_COMPILE_DEFS}
			"ICE_DISCOVERY_API_EXPORTS"
	)

	target_link_libraries(icediscovery++11
		PRIVATE
			ice++11
	)

	if(MSVC)
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

		target_sources(icediscovery++11
			PRIVATE
				IceDiscovery.rc
		)

		target_compile_options(icediscovery++11 
			PRIVATE
				${ICE_MSVC_COMPILE_OPTIONS}   
		)

		target_compile_definitions(icediscovery++11
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
		)
	endif()

	set_target_properties(icediscovery++11 
		PROPERTIES
			OUTPUT_NAME IceDiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS}
	)

	install(TARGETS icediscovery++11 DESTINATION lib)
endif()
