if(NOT ${GENERATED_SLICES_DIR}/IceStorm)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceStorm)
endif()

set(ICESTORM_SLICES
	${SLICE_DIR}/IceStorm/IceStorm.ice
	${SLICE_DIR}/IceStorm/Metrics.ice
)

set(GENERATED_ICESTORM_HEADERS
	${GENERATED_SLICES_DIR}/IceStorm/IceStorm.h
	${GENERATED_SLICES_DIR}/IceStorm/Metrics.h
)

set(GENERATED_ICESTORM_SOURCES
	${GENERATED_SLICES_DIR}/IceStorm/IceStorm.cpp
	${GENERATED_SLICES_DIR}/IceStorm/Metrics.cpp
)

add_library(icestorm)

target_sources(icestorm
	PRIVATE
		${GENERATED_ICESTORM_HEADERS}
		${GENERATED_ICESTORM_SOURCES}
)

target_include_directories(icestorm
	PRIVATE 
		${PROJECT_BINARY_DIR}/generated
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(icestorm
	PRIVATE
		${ICE_COMPILE_DEFS}
		"ICESTORM_API_EXPORTS"
)

target_link_libraries(icestorm
	PRIVATE
		ice
)

if(MSVC)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceStorm.rc
	)

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

	target_sources(icestorm
		PRIVATE
			IceStorm.rc
	)

	target_compile_options(icestorm 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}   
	)

	target_compile_definitions(icestorm
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)
endif()

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

if(CMAKE_CXX_STANDARD EQUAL 11)
	set_target_properties(icestorm 
		PROPERTIES
			OUTPUT_NAME IceStorm${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
	)
elseif(CMAKE_CXX_STANDARD EQUAL 98)
	set_target_properties(icestorm 
		PROPERTIES
			OUTPUT_NAME IceStorm${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
	)
endif()

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceStorm 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)
install(TARGETS icestorm DESTINATION lib)
