if(NOT ${GENERATED_SLICES_DIR}/IceBox)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceBox)
endif()

set(ICEBOXLIB_SLICES
	${SLICE_DIR}/IceBox/IceBox.ice
)

set(GENERATED_ICEBOXLIB_HEADERS
	${GENERATED_SLICES_DIR}/IceBox/IceBox.h
)

set(GENERATED_ICEBOXLIB_SOURCES
	${GENERATED_SLICES_DIR}/IceBox/IceBox.cpp
)

add_library(iceboxlib)

target_sources(iceboxlib
	PRIVATE
		Exception.cpp
		${GENERATED_ICEBOXLIB_HEADERS}
		${GENERATED_ICEBOXLIB_SOURCES}
		${ICEBOXLIB_SLICES}
)

target_include_directories(iceboxlib
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(iceboxlib 
	PRIVATE 
		${ICE_COMPILE_DEFS}
		"ICEBOX_API_EXPORTS"
)

target_link_libraries(iceboxlib
	PRIVATE
		ice
)

if(MSVC)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceBox.rc
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceBox
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_ICEBOXLIB_HEADERS}
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceBox
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_ICEBOXLIB_SOURCES}
	)

	source_group(
		TREE ${SLICE_DIR}/IceBox
		PREFIX "Slice Files"
		FILES
			${ICEBOXLIB_SLICES}
	)

	target_sources(iceboxlib
		PRIVATE
			IceBox.rc
	)

	target_compile_options(iceboxlib 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}   
	)

	target_compile_definitions(iceboxlib
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)
endif()

list(APPEND ICEBOXLIB_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICEBOXLIB_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceBox")

foreach(slice ${ICEBOXLIB_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${GENERATED_SLICES_DIR}/IceBox/${slice_name}.cpp 
		${GENERATED_SLICES_DIR}/IceBox/${slice_name}.h
	)
	#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice(slice2cpp
		"${ICEBOXLIB_SLICE_PARAMS}"
		"${ICEBOXLIB_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/IceBox
		"${output_files}"
	)
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
	set_target_properties(iceboxlib 
		PROPERTIES
			OUTPUT_NAME IceBox${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
	)
elseif(CMAKE_CXX_STANDARD EQUAL 98)
	set_target_properties(iceboxlib 
		PROPERTIES
			OUTPUT_NAME IceBox${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
	)
endif()

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceBox 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)

install(TARGETS iceboxlib DESTINATION lib)

add_executable(icebox)

target_sources(icebox 
	PRIVATE
		Service.cpp
		ServiceManagerI.cpp
		ServiceManagerI.h
)

target_include_directories(icebox
	PRIVATE
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${BZIP2_INCLUDE_DIR}
)

target_compile_definitions(icebox
	PRIVATE
		${ICE_COMPILE_DEFS}
)

target_link_libraries(icebox
	PRIVATE
		ice
		iceboxlib
		BZip2::BZip2
)

if(MSVC)
	target_sources(icebox
		PRIVATE
			IceBoxExe.rc
	)

	target_compile_options(icebox
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	target_compile_definitions(icebox
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)

	target_link_options(icebox
		PRIVATE
			${ICE_MSVC_LINK_OPTIONS}
	)

	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceBoxExe.rc
	)
endif()

install(TARGETS icebox DESTINATION bin)

if(CMAKE_CXX_STANDARD EQUAL 98)
	add_executable(iceboxadmin)

	target_sources(iceboxadmin
		PRIVATE
			Admin.cpp
	)

	target_include_directories(iceboxadmin
		PRIVATE
			${GENERATED_SLICES_DIR}
			${PROJECT_SOURCE_DIR}/cpp/include
			${PROJECT_SOURCE_DIR}/cpp/src
	)

	target_link_libraries(iceboxadmin
		PRIVATE
			iceboxlib
			ice
			BZip2::BZip2
	)

	target_compile_definitions(iceboxadmin
		PRIVATE
			${ICE_COMPILE_DEFS}
	)
	
	if(MSVC)
		target_sources(iceboxadmin
			PRIVATE
				IceBoxAdmin.rc
		)

		target_compile_options(iceboxadmin
			PRIVATE
				${ICE_MSVC_COMPILE_OPTIONS}
		)

		target_compile_definitions(iceboxadmin
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
		)

		target_link_options(iceboxadmin
			PRIVATE
				${ICE_MSVC_LINK_OPTIONS}
		)

		target_link_libraries(iceboxadmin
			PRIVATE
				advapi32.lib
				ws2_32.lib
				Iphlpapi.lib
				rpcrt4.lib
				DbgHelp.lib
				Shlwapi.lib
		)

		source_group(
			TREE ${CMAKE_CURRENT_SOURCE_DIR}
			PREFIX "Resource Files"
			FILES
				IceBoxAdmin.rc
		)
	endif()

	install(TARGETS iceboxadmin DESTINATION bin)
endif()
