if(NOT ${GENERATED_SLICES_DIR}/Glacier2)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/Glacier2)
endif()

set(GENERATED_GLACIER2_HEADERS
	${GENERATED_SLICES_DIR}/Glacier2/Metrics.h
	${GENERATED_SLICES_DIR}/Glacier2/PermissionsVerifier.h
	${GENERATED_SLICES_DIR}/Glacier2/PermissionsVerifierF.h
	${GENERATED_SLICES_DIR}/Glacier2/Router.h
	${GENERATED_SLICES_DIR}/Glacier2/RouterF.h
	${GENERATED_SLICES_DIR}/Glacier2/Session.h
	${GENERATED_SLICES_DIR}/Glacier2/SSLInfo.h
)

set(GENERATED_GLACIER2_SOURCES
	${GENERATED_SLICES_DIR}/Glacier2/Metrics.cpp
	${GENERATED_SLICES_DIR}/Glacier2/PermissionsVerifier.cpp
	${GENERATED_SLICES_DIR}/Glacier2/PermissionsVerifierF.cpp
	${GENERATED_SLICES_DIR}/Glacier2/Router.cpp
	${GENERATED_SLICES_DIR}/Glacier2/RouterF.cpp
	${GENERATED_SLICES_DIR}/Glacier2/Session.cpp
	${GENERATED_SLICES_DIR}/Glacier2/SSLInfo.cpp
)

if(BUILD_ICE_UWP)
	set(GLACIER2_SOURCES
		SessionHelper.cpp
	)
else()
	set(GLACIER2_SOURCES
		Application.cpp
		NullPermissionsVerifier.cpp
		SessionHelper.cpp
	)
endif()

list(APPEND GLACIER2_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND GLACIER2_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "Glacier2")

foreach(slice ${GLACIER2_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${GENERATED_SLICES_DIR}/Glacier2/${slice_name}.cpp 
		${GENERATED_SLICES_DIR}/Glacier2/${slice_name}.h
	)
	#function(CompileSlice slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice("${GLACIER2_SLICE_PARAMS}"
		"${GLACIER2_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/Glacier2
		"${output_files}"
	)
endforeach()

install(DIRECTORY ${GENERATED_SLICES_DIR}/Glacier2 
	DESTINATION ${GENERATED_H_INSTALL_DIR}
	FILES_MATCHING PATTERN "*.h"
)

if(BUILD_ICE_CPP98)
	set(GLACIER2_TARGET glacier2)

	add_library(${GLACIER2_TARGET})

	set_target_properties(${GLACIER2_TARGET} 
		PROPERTIES
			OUTPUT_NAME Glacier2${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
			CXX_STANDARD 98
	)

	target_link_libraries(${GLACIER2_TARGET} PRIVATE ice)
elseif(BUILD_ICE_CPP11)
	set(GLACIER2_TARGET glacier2++11)

	add_library(${GLACIER2_TARGET})

	set_target_properties(${GLACIER2_TARGET} 
		PROPERTIES
			OUTPUT_NAME Glacier2${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			CXX_STANDARD 11
	)

	target_link_libraries(${GLACIER2_TARGET} PRIVATE ice++11)
elseif(BUILD_ICE_UWP)
	set(GLACIER2_TARGET glacier2uwp++11)

	add_library(${GLACIER2_TARGET} STATIC)
	
	set_target_properties(${GLACIER2_TARGET} 
		PROPERTIES
			OUTPUT_NAME Glacier2${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}uwp++11
			CXX_STANDARD 11
			LINK_FLAGS ${ICE_UWP_LINK_OPTIONS}
	)

	add_dependencies(${GLACIER2_TARGET} iceuwp++11)
endif()

target_sources(${GLACIER2_TARGET}
	PRIVATE
		${GLACIER2_SOURCES}
		${GENERATED_GLACIER2_HEADERS}
		${GENERATED_GLACIER2_SOURCES}
		${GLACIER2_SLICES}
)

target_include_directories(${GLACIER2_TARGET}
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src       
)

if(NOT BUILD_ICE_UWP)
	target_compile_definitions(${GLACIER2_TARGET} 
		PRIVATE 
			${ICE_COMPILE_DEFS}
			"GLACIER2_API_EXPORTS"
	)
else()
	target_compile_definitions(${GLACIER2_TARGET} 
		PRIVATE 
			${ICE_COMPILE_DEFS}
			"ICE_BUILDING_GLACIER2"
	)
endif()

if(MSVC)
	if(NOT BUILD_ICE_UWP)
		source_group(
			TREE ${CMAKE_CURRENT_SOURCE_DIR}
			PREFIX "Resource Files"
			FILES
				Glacier2.rc
		)
		
		target_sources(${GLACIER2_TARGET}
			PRIVATE
				Glacier2.rc
		)
	endif()

	source_group(
		TREE ${GENERATED_SLICES_DIR}/Glacier2
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_GLACIER2_HEADERS}
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/Glacier2
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_GLACIER2_SOURCES}
	)

	source_group(
		TREE ${SLICE_DIR}/Glacier2
		PREFIX "Slice Files"
		FILES
			${GLACIER2_SLICES}
	)

	set_property(TARGET ${GLACIER2_TARGET} PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})

	target_compile_options(${GLACIER2_TARGET}  
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}   
	)
endif()

if(BUILD_SHARED_LIBS AND NOT BUILD_ICE_UWP)
	install(TARGETS ${GLACIER2_TARGET} DESTINATION bin)
else()
	install(TARGETS ${GLACIER2_TARGET} DESTINATION lib)
endif()
