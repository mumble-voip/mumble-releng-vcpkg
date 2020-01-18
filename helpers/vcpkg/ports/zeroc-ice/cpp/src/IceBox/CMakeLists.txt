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

set(ICEBOXLIB_SOURCES
	Exception.cpp
	${ICEBOXLIB_SLICES}
)

set(ICEBOX_SOURCES
	Service.cpp
	ServiceManagerI.cpp
	ServiceManagerI.h
)

if(NOT WINDOWS_STORE)
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
endif()

add_library(iceboxlib)

target_sources(iceboxlib
	PRIVATE
		${ICEBOXLIB_SOURCES}
		${GENERATED_ICEBOXLIB_HEADERS}
		${GENERATED_ICEBOXLIB_SOURCES}
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
)

if(BUILD_SHARED_LIBS)
	target_compile_definitions(iceboxlib PRIVATE "ICEBOX_API_EXPORTS")
endif()

target_link_libraries(iceboxlib
	PRIVATE
		ice
		iceutil
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

set_target_properties(iceboxlib 
	PROPERTIES
		OUTPUT_NAME IceBox${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
)

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceBox 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)

install(TARGETS iceboxlib DESTINATION lib)

add_library(iceboxlib++11)

target_sources(iceboxlib++11
	PRIVATE
		${ICEBOXLIB_SOURCES}
		${GENERATED_ICEBOXLIB_HEADERS}
		${GENERATED_ICEBOXLIB_SOURCES}
)

target_include_directories(iceboxlib++11
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(iceboxlib++11 
	PRIVATE 
		${ICE_COMPILE_DEFS}
		${ICE_CPP11_COMPILE_DEFS}
)

if(BUILD_SHARED_LIBS)
	target_compile_definitions(iceboxlib++11 PRIVATE "ICEBOX_API_EXPORTS")
endif()

target_link_libraries(iceboxlib++11
	PRIVATE
		ice++11
		iceutil
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

	target_sources(iceboxlib++11
		PRIVATE
			IceBox.rc
	)

	target_compile_options(iceboxlib++11 
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}   
	)

	target_compile_definitions(iceboxlib++11
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)
endif()

set_target_properties(iceboxlib++11 
	PROPERTIES
		OUTPUT_NAME IceBox${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
)

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceBox 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)

install(TARGETS iceboxlib++11 DESTINATION lib)

add_executable(icebox)

target_sources(icebox 
	PRIVATE
		${ICEBOX_SOURCES}
)

target_include_directories(icebox
	PRIVATE
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(icebox
	PRIVATE
		${ICE_COMPILE_DEFS}
)

target_link_libraries(icebox
	PRIVATE
		ice
		iceboxlib
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

add_executable(icebox++11)

target_sources(icebox++11 
	PRIVATE
		${ICEBOX_SOURCES}
)

target_include_directories(icebox++11
	PRIVATE
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(icebox++11
	PRIVATE
		${ICE_COMPILE_DEFS}
		${ICE_CPP11_COMPILE_DEFS}
)

target_link_libraries(icebox++11
	PRIVATE
		iceboxlib++11
		ice++11
)

if(MSVC)
	target_sources(icebox++11
		PRIVATE
			IceBoxExe.rc
	)

	target_compile_options(icebox++11
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	target_compile_definitions(icebox++11
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)

	target_link_options(icebox++11
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

install(TARGETS icebox++11 DESTINATION bin)

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
