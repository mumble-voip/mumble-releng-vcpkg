if(NOT ${GENERATED_SLICES_DIR}/Glacier2)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/Glacier2)
endif()

set(GLACIER2_SLICES
	${SLICE_DIR}/Glacier2/Metrics.ice
	${SLICE_DIR}/Glacier2/PermissionsVerifier.ice
	${SLICE_DIR}/Glacier2/PermissionsVerifierF.ice
	${SLICE_DIR}/Glacier2/Router.ice
	${SLICE_DIR}/Glacier2/RouterF.ice
	${SLICE_DIR}/Glacier2/Session.ice
	${SLICE_DIR}/Glacier2/SSLInfo.ice
)

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

set(GLACIER2 SOURCES
	Application.cpp
	NullPermissionsVerifier.cpp
	SessionHelper.cpp
	${GLACIER2_SLICES}
)

if(NOT WINDOWS_STORE)
	list(APPEND GLACIER2_SLICE_DIRS "-I${SLICE_DIR}")
	list(APPEND GLACIER2_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "Glacier2")

	foreach(slice ${GLACIER2_SLICES})
		get_filename_component(slice_name ${slice} NAME_WE)
		set(output_files 
			${GENERATED_SLICES_DIR}/Glacier2/${slice_name}.cpp 
			${GENERATED_SLICES_DIR}/Glacier2/${slice_name}.h
		)
		#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
		CompileSlice(slice2cpp
			"${GLACIER2_SLICE_PARAMS}"
			"${GLACIER2_SLICE_DIRS}"
			${slice}
			${GENERATED_SLICES_DIR}/Glacier2
			"${output_files}"
		)
	endforeach()

	add_library(glacier2)

	target_sources(glacier2
		PRIVATE
			${GLACIER2_SOURCES}
			${GENERATED_GLACIER2_HEADERS}
			${GENERATED_GLACIER2_SOURCES}
	)

	target_include_directories(glacier2
		PRIVATE 
			${GENERATED_SLICES_DIR}
			${PROJECT_SOURCE_DIR}/cpp/include
			${PROJECT_SOURCE_DIR}/cpp/src       
	)

	target_compile_definitions(glacier2 
		PRIVATE 
			${ICE_COMPILE_DEFS}
	)

	if(BUILD_SHARED_LIBS)
		target_compile_definitions(glacier2 PRIVATE "GLACIER2_API_EXPORTS")
	endif()

	target_link_libraries(glacier2
		PRIVATE
			ice
			#iceutil
	)

	if(MSVC)
		source_group(
			TREE ${CMAKE_CURRENT_SOURCE_DIR}
			PREFIX "Resource Files"
			FILES
				Glacier2.rc
		)

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

		target_sources(glacier2
			PRIVATE
				Glacier2.rc
		)

		target_compile_options(glacier2  
			PRIVATE
				${ICE_MSVC_COMPILE_OPTIONS}   
		)

		target_compile_definitions(glacier2
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
		)
	endif()

	set_target_properties(glacier2  
		PROPERTIES
			OUTPUT_NAME Glacier2${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
	)

	install(DIRECTORY ${GENERATED_SLICES_DIR}/Glacier2 
		DESTINATION include
		FILES_MATCHING PATTERN "*.h"
	)
	install(TARGETS glacier2 DESTINATION lib)

	add_library(glacier2++11)

	target_sources(glacier2++11
		PRIVATE
			${GLACIER2_SOURCES}
			${GENERATED_GLACIER2_HEADERS}
			${GENERATED_GLACIER2_SOURCES}
	)

	target_include_directories(glacier2++11
		PRIVATE 
			${GENERATED_SLICES_DIR}
			${PROJECT_SOURCE_DIR}/cpp/include
			${PROJECT_SOURCE_DIR}/cpp/src    
	)

	target_compile_definitions(glacier2++11 
		PRIVATE 
			${ICE_COMPILE_DEFS}
			${ICE_CPP11_COMPILE_DEFS}
	)

	if(BUILD_SHARED_LIBS)
		target_compile_definitions(glacier2++11 PRIVATE "GLACIER2_API_EXPORTS")
	endif()

	target_link_libraries(glacier2++11
		PRIVATE
			ice++11
			#iceutil
	)

	if(MSVC)
		source_group(
			TREE ${CMAKE_CURRENT_SOURCE_DIR}
			PREFIX "Resource Files"
			FILES
				Glacier2.rc
		)

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

		target_sources(glacier2++11
			PRIVATE
				Glacier2.rc
		)

		target_compile_options(glacier2++11 
			PRIVATE
				${ICE_MSVC_COMPILE_OPTIONS}   
		)

		target_compile_definitions(glacier2++11
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
		)
	endif()

	set_target_properties(glacier2++11 
	PROPERTIES
		OUTPUT_NAME Glacier2${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
	)

	install(DIRECTORY ${GENERATED_SLICES_DIR}/Glacier2 
		DESTINATION include
		FILES_MATCHING PATTERN "*.h"
	)
	install(TARGETS glacier2++11 DESTINATION lib)
endif()
