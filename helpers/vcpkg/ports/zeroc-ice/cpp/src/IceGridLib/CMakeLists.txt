if(NOT ${GENERATED_SLICES_DIR}/IceGrid)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid)
endif()

set(ICEGRID_SLICES
	${SLICE_DIR}/IceGrid/Admin.ice
	${SLICE_DIR}/IceGrid/Descriptor.ice
	${SLICE_DIR}/IceGrid/Exception.ice
	${SLICE_DIR}/IceGrid/FileParser.ice
	${SLICE_DIR}/IceGrid/PluginFacade.ice
	${SLICE_DIR}/IceGrid/Registry.ice
	${SLICE_DIR}/IceGrid/Session.ice
	${SLICE_DIR}/IceGrid/UserAccountMapper.ice
)

set(GENERATED_ICEGRID_HEADERS
	${GENERATED_SLICES_DIR}/IceGrid/Admin.h
	${GENERATED_SLICES_DIR}/IceGrid/Descriptor.h
	${GENERATED_SLICES_DIR}/IceGrid/Exception.h
	${GENERATED_SLICES_DIR}/IceGrid/FileParser.h
	${GENERATED_SLICES_DIR}/IceGrid/PluginFacade.h
	${GENERATED_SLICES_DIR}/IceGrid/Registry.h
	${GENERATED_SLICES_DIR}/IceGrid/Session.h
	${GENERATED_SLICES_DIR}/IceGrid/UserAccountMapper.h
)

set(GENERATED_ICEGRID_SOURCES
	${GENERATED_SLICES_DIR}/IceGrid/Admin.cpp
	${GENERATED_SLICES_DIR}/IceGrid/Descriptor.cpp
	${GENERATED_SLICES_DIR}/IceGrid/Exception.cpp
	${GENERATED_SLICES_DIR}/IceGrid/FileParser.cpp
	${GENERATED_SLICES_DIR}/IceGrid/PluginFacade.cpp
	${GENERATED_SLICES_DIR}/IceGrid/Registry.cpp
	${GENERATED_SLICES_DIR}/IceGrid/Session.cpp
	${GENERATED_SLICES_DIR}/IceGrid/UserAccountMapper.cpp
)

set(ICEGRID_SOURCES
	PluginFacadeI.cpp
)

if(NOT WINDOWS_STORE)
	list(APPEND ICEGRID_SLICE_DIRS "-I${SLICE_DIR}")
	list(APPEND ICEGRID_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceGrid")

	foreach(slice ${ICEGRID_SLICES})
		get_filename_component(slice_name ${slice} NAME_WE)
		set(output_files 
			${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.cpp
			${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.h
		)
		#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
		CompileSlice(slice2cpp
			"${ICEGRID_SLICE_PARAMS}"
			"${ICEGRID_SLICE_DIRS}"
			${slice}
			${GENERATED_SLICES_DIR}/IceGrid
			"${output_files}"
		)
	endforeach()
endif()

add_library(icegrid)

target_sources(icegrid
	PRIVATE
		${ICEGRID_SOURCES}
		${GENERATED_ICEGRID_HEADERS}
		${GENERATED_ICEGRID_SOURCES}
		${ICEGRID_SLICES} 
)

if(LINUX OR APPLE)
	target_sources(icegrid
		PRIVATE
			Grammar.y
			Scanner.l
	)
endif()

target_include_directories(icegrid
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src  
)

target_compile_definitions(icegrid
	PRIVATE
		${ICE_COMPILE_DEFS}
)

if(BUILD_SHARED_LIBS)
	target_compile_definitions(icegrid PRIVATE "ICEGRID_API_EXPORTS")
endif()

target_link_libraries(icegrid
	PRIVATE
		ice
		glacier2
	)

if(MSVC)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceGrid.rc
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceGrid
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_ICEGRID_HEADERS}
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceGrid
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_ICEGRID_SOURCES}
	)

	source_group(
		TREE ${SLICE_DIR}/IceGrid
		PREFIX "Slice Files"
		FILES
			${ICEGRID_SLICES}
	)

	target_sources(icegrid
		PRIVATE
			IceGrid.rc
	)

	target_compile_options(icegrid
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}   
	)

	target_compile_definitions(icegrid
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)
endif()

set_target_properties(icegrid 
	PROPERTIES
		OUTPUT_NAME IceGrid${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
)

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)
install(TARGETS icegrid DESTINATION lib)

add_library(icegrid++11)

target_sources(icegrid++11
	PRIVATE
		${ICEGRID_SOURCES}
		${GENERATED_ICEGRID_HEADERS}
		${GENERATED_ICEGRID_SOURCES}
		${ICEGRID_SLICES} 
)

if(LINUX OR APPLE)
	target_sources(icegrid++11
		PRIVATE
			Grammar.y
			Scanner.l
	)
endif()

target_include_directories(icegrid++11
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src  
)

target_compile_definitions(icegrid++11
	PRIVATE
		${ICE_COMPILE_DEFS}
		${ICE_CPP11_COMPILE_DEFS}
)

if(BUILD_SHARED_LIBS)
	target_compile_definitions(icegrid++11 PRIVATE "ICEGRID_API_EXPORTS")
endif()

target_link_libraries(icegrid++11
	PRIVATE
		ice++11
		glacier2++11
	)

if(MSVC)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceGrid.rc
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceGrid
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_ICEGRID_HEADERS}
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceGrid
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_ICEGRID_SOURCES}
	)

	source_group(
		TREE ${SLICE_DIR}/IceGrid
		PREFIX "Slice Files"
		FILES
			${ICEGRID_SLICES}
	)

	target_sources(icegrid++11
		PRIVATE
			IceGrid.rc
	)

	target_compile_options(icegrid++11
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}   
	)

	target_compile_definitions(icegrid++11
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)
endif()

set_target_properties(icegrid++11 
	PROPERTIES
		OUTPUT_NAME IceGrid${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
)

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)
install(TARGETS icegrid++11 DESTINATION lib)
