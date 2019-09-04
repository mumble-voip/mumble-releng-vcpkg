if(NOT ${PROJECT_BINARY_DIR}/generated/IceBox)
	file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceBox)
endif()

set(GENERATED_ICEBOX_SOURCES_DIR 
   ${PROJECT_BINARY_DIR}/generated/IceBox
)

set(ICEBOX_SLICES
	${SLICE_DIR}/IceBox/IceBox.ice
)

set(GENERATED_ICEBOX_HEADERS
	${GENERATED_ICEBOX_SOURCES_DIR}/IceBox.h
)

set(GENERATED_ICEBOX_SOURCES
	${GENERATED_ICEBOX_SOURCES_DIR}/IceBox.cpp
)

set_source_files_properties(
   ${GENERATED_ICEBOX_HEADERS}
   ${GENERATED_ICEBOX_SOURCES} 
   PROPERTIES 
      GENERATED TRUE
)

add_library(${ICEBOXLIB_TARGET_NAME})

target_sources(${ICEBOXLIB_TARGET_NAME}
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include/IceBox/Config.h
		Exception.cpp
		${GENERATED_ICEBOX_HEADERS}
		${GENERATED_ICEBOX_SOURCES}
)

target_include_directories(${ICEBOXLIB_TARGET_NAME}
	PRIVATE 
		${PROJECT_BINARY_DIR}/generated
   	${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)


if(CMAKE_CXX_STANDARD EQUAL 11)
	set(ICEBOX_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
else()
	set(ICEBOX_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS")
endif()

target_compile_definitions(${ICEBOXLIB_TARGET_NAME} 
   PRIVATE 
		${ICEBOX_COMPILE_DEFS}
		"ICEBOX_API_EXPORTS"
)

add_dependencies(${ICEBOXLIB_TARGET_NAME} ${ICE_TARGET_NAME})

if(WIN32)
   source_group(
      TREE ${CMAKE_CURRENT_SOURCE_DIR}
      PREFIX "Resource Files"
      FILES
         ${CMAKE_CURRENT_SOURCE_DIR}/IceBox.rc
   )

   source_group(
      TREE ${GENERATED_ICEBOX_SOURCES_DIR}
      PREFIX "Header Files/Generated"
      FILES
         ${GENERATED_ICEBOX_HEADERS}
   )

   source_group(
      TREE ${GENERATED_ICEBOX_SOURCES_DIR}
      PREFIX "Source Files/Generated"
      FILES
         ${GENERATED_ICEBOX_SOURCES}
   )

   source_group(
      TREE ${SLICE_DIR}/IceBox
      PREFIX "Slice Files"
      FILES
         ${ICEBOX_SLICES}
   )

   target_sources(${ICEBOXLIB_TARGET_NAME}
   PRIVATE
      IceBox.rc
   )

   target_compile_options(${ICEBOXLIB_TARGET_NAME} 
   PRIVATE
      ${ICE_COMPILE_OPTIONS}   
   )
endif()

foreach(slice ${ICEBOX_SLICES})
	#function(CompileSlices slice2_bin slice_path ice_file slice_target optional_args output_dir)
	CompileSlices(slice2cpp
		${SLICE_DIR}
		${slice}
		${ICEBOXLIB_TARGET_NAME}
		""
		${GENERATED_ICEBOX_SOURCES_DIR}
	)
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
	set_target_properties(${ICEBOXLIB_TARGET_NAME} 
		PROPERTIES
			OUTPUT_NAME icebox${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
	)
elseif(CMAKE_CXX_STANDARD EQUAL 98)
	set_target_properties(${ICEBOXLIB_TARGET_NAME} 
		PROPERTIES
			OUTPUT_NAME icebox${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
	)
endif()

install(TARGETS ${ICEBOXLIB_TARGET_NAME} DESTINATION lib)

add_executable(${ICEBOX_TARGET_NAME})

target_sources(${ICEBOX_TARGET_NAME} 
   PRIVATE
		Service.cpp
		ServiceManagerI.cpp
		ServiceManagerI.h
)

if(WIN32)
	target_sources(${ICEBOX_TARGET_NAME}
		PRIVATE
			IceBoxExe.rc
	)

	target_compile_options(${ICEBOX_TARGET_NAME}
		PRIVATE
			${ICE_COMPILE_OPTIONS}
	)

	target_link_options(${ICEBOX_TARGET_NAME}
		PRIVATE
			${ICE_APP_ADDITIONAL_DEPS}
	)

	source_group(
      TREE ${CMAKE_CURRENT_SOURCE_DIR}
      PREFIX "Resource Files"
      FILES
         ${CMAKE_CURRENT_SOURCE_DIR}/IceBoxExe.rc
   )

endif()

target_compile_definitions(${ICEBOX_TARGET_NAME}
	PRIVATE
		${ICEBOX_COMPILE_DEFS}
)

add_dependencies(${ICEBOX_TARGET_NAME}	${ICEBOXLIB_TARGET_NAME})

target_include_directories(${ICEBOX_TARGET_NAME}
	PRIVATE 
		${PROJECT_BINARY_DIR}/generated
   	${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

set_target_properties(${ICEBOX_TARGET_NAME}
	PROPERTIES
		OUTPUT_NAME icebox
)

install(TARGETS ${ICEBOX_TARGET_NAME} DESTINATION bin)
