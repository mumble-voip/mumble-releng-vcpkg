if(NOT ${GENERATED_SLICES_DIR}/IceStorm)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceStorm)
endif()

set(GENERATED_ICESTORM_HEADERS
	${GENERATED_SLICES_DIR}/IceStorm/IceStorm.h
	${GENERATED_SLICES_DIR}/IceStorm/Metrics.h
)

set(GENERATED_ICESTORM_SOURCES
	${GENERATED_SLICES_DIR}/IceStorm/IceStorm.cpp
	${GENERATED_SLICES_DIR}/IceStorm/Metrics.cpp
)

list(APPEND ICESTORM_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICESTORM_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceStorm")

foreach(slice ${ICESTORM_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${GENERATED_SLICES_DIR}/IceStorm/${slice_name}.cpp
		${GENERATED_SLICES_DIR}/IceStorm/${slice_name}.h
	)
	#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice(slice2cpp
		"${ICESTORM_SLICE_PARAMS}"
		"${ICESTORM_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/IceStorm
		"${output_files}"
	)
endforeach()

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceStorm 
	DESTINATION ${GENERATED_H_INSTALL_DIR}
	FILES_MATCHING PATTERN "*.h"
)

if(BUILD_ICE_CPP98)
	set(ICESTORMLIB_TARGET icestorm)
	add_library(${ICESTORMLIB_TARGET})
	set_target_properties(${ICESTORMLIB_TARGET} 
		PROPERTIES
			OUTPUT_NAME IceStorm${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
			CXX_STANDARD 98
	)
elseif(BUILD_ICE_CPP11)
	set(ICESTORMLIB_TARGET icestorm++11)
	add_library(${ICESTORMLIB_TARGET})
	set_target_properties(${ICESTORMLIB_TARGET} 
		PROPERTIES
			OUTPUT_NAME IceStorm${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			CXX_STANDARD 11
	)
elseif(BUILD_ICE_UWP)
	set(ICESTORMLIB_TARGET icestormuwp++11)
	add_library(${ICESTORMLIB_TARGET} STATIC)
	set_target_properties(${ICESTORMLIB_TARGET} 
		PROPERTIES
			OUTPUT_NAME IceStorm${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			CXX_STANDARD 11
	)
endif()

target_sources(${ICESTORMLIB_TARGET}
	PRIVATE
		${GENERATED_ICESTORM_HEADERS}
		${GENERATED_ICESTORM_SOURCES}
)

target_include_directories(${ICESTORMLIB_TARGET}
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

if(NOT BUILD_ICE_UWP)
	target_compile_definitions(${ICESTORMLIB_TARGET}
		PRIVATE
			${ICE_COMPILE_DEFS}
			"ICESTORM_API_EXPORTS"
	)
else()
	target_compile_definitions(${ICESTORMLIB_TARGET}
		PRIVATE
			${ICE_COMPILE_DEFS}
			"ICE_BUILDING_ICE_STORM"
	)
endif()

if(BUILD_ICE_CPP98)
	target_link_libraries(${ICESTORMLIB_TARGET} PRIVATE ice)
elseif(BUILD_ICE_CPP11)
	target_link_libraries(${ICESTORMLIB_TARGET} PRIVATE ice++11)
elseif(BUILD_ICE_UWP)
	add_dependencies(${ICESTORMLIB_TARGET} iceuwp++11)
endif()

if(MSVC)
	if(NOT BUILD_ICE_UWP)
		source_group(
			TREE ${CMAKE_CURRENT_SOURCE_DIR}
			PREFIX "Resource Files"
			FILES
				IceStorm.rc
		)

		target_sources(${ICESTORMLIB_TARGET}
			PRIVATE
				IceStorm.rc
		)
	endif()

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceStorm
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_ICESTORM_HEADERS}
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceStorm
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_ICESTORM_SOURCES}
	)

	source_group(
		TREE ${SLICE_DIR}/IceStorm
		PREFIX "Slice Files"
		FILES
			${ICESTORM_SLICES}
	)

	set_property(TARGET ${ICESTORMLIB_TARGET} PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})

	target_compile_options(${ICESTORMLIB_TARGET} 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}   
	)
endif()

install(TARGETS ${ICESTORMLIB_TARGET} 
	RUNTIME DESTINATION bin
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib
)
