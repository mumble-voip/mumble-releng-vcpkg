if(NOT ${GENERATED_SLICES_DIR}/IceGrid)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid)
endif()

set(ICEGRIDDB_SLICES
	${CMAKE_CURRENT_SOURCE_DIR}/DBTypes.ice
	${SLICE_DIR}/IceGrid/Descriptor.ice
	${SLICE_DIR}/IceGrid/Exception.ice
)

set(GENERATED_ICEGRIDDB_HEADERS
	${GENERATED_SLICES_DIR}/IceGrid/DBTypes.h
	${GENERATED_SLICES_DIR}/IceGrid/Descriptor.h
	${GENERATED_SLICES_DIR}/IceGrid/Exception.h
)

set(GENERATED_ICEGRIDDB_SOURCES
	${GENERATED_SLICES_DIR}/IceGrid/DBTypes.cpp
	${GENERATED_SLICES_DIR}/IceGrid/Descriptor.cpp
	${GENERATED_SLICES_DIR}/IceGrid/Exception.cpp
)

add_executable(icegriddb)

target_sources(icegriddb
	PRIVATE
		IceGridDB.cpp
		${GENERATED_ICEGRIDDB_HEADERS}
		${GENERATED_ICEGRIDDB_SOURCES}
		${ICEGRIDDB_SLICES}
)

target_include_directories(icegriddb
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${LMDB_INCLUDE_DIR}
		${BZIP2_INCLUDE_DIR} 
)

target_compile_definitions(icegriddb
	PRIVATE
		${ICE_COMPILE_DEFS}
		"ICE_BUILDING_ICE_GRID"
)

target_link_libraries(icegriddb
	PRIVATE
		lmdb
		ice
		icedb
		glacier2
		BZip2::BZip2
)

if(WIN32)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceGridDB.rc
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceGrid
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_ICEGRIDDB_HEADERS}
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceGrid
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_ICEGRIDDB_SOURCES}
	)

	source_group("Slice Files"
		FILES
			${ICEGRIDDB_SLICES}
	)

	target_sources(icegriddb
		PRIVATE
			IceGridDB.rc
	)

	target_compile_options(icegriddb
		PRIVATE
			${ICE_WIN32_COMPILE_OPTIONS}   
	)

	target_compile_definitions(icegriddb
		PRIVATE
			${ICE_WIN32_COMPILE_DEFS}
	)

	target_link_options(icegriddb
		PRIVATE
			${ICE_WIN32_LINK_OPTIONS}
	)

	target_link_libraries(icegriddb
		PRIVATE
			advapi32.lib
			ws2_32.lib
			Iphlpapi.lib
			rpcrt4.lib
			DbgHelp.lib
			Shlwapi.lib
	)
endif()

list(APPEND ICEGRIDDB_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICEGRIDDB_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceGrid")

foreach(slice ${ICEGRIDDB_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.cpp
		${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.h
	)
	#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice(slice2cpp
		"${ICEGRIDDB_SLICE_PARAMS}"
		"${ICEGRIDDB_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/IceGrid
		"${output_files}"
	)
endforeach()

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)

set_target_properties(icegriddb
	PROPERTIES
		OUTPUT_NAME IceGridDB
)

install(TARGETS icegriddb DESTINATION bin)
