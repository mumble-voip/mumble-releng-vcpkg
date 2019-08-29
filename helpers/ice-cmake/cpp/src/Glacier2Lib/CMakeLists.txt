if(NOT ${PROJECT_BINARY_DIR}/generated/Glacier2)
	file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/Glacier2)
endif()

set(GENERATED_GLACIER2_SOURCES_DIR 
   ${PROJECT_BINARY_DIR}/generated/Glacier2
)

set(GLACIER2_SLICES
   ${SLICE_DIR}/Glacier2/Metrics.ice
   ${SLICE_DIR}/Glacier2/PermissionsVerifier.ice
   ${SLICE_DIR}/Glacier2/PermissionsVerifierF.ice
   ${SLICE_DIR}/Glacier2/Router.ice
   ${SLICE_DIR}/Glacier2/RouterF.ice
   ${SLICE_DIR}/Glacier2/SSLInfo.ice
   ${SLICE_DIR}/Glacier2/Session.ice
)

set(GENERATED_GLACIER2_HEADERS
   ${GENERATED_GLACIER2_SOURCES_DIR}/Metrics.h
   ${GENERATED_GLACIER2_SOURCES_DIR}/PermissionsVerifier.h
   ${GENERATED_GLACIER2_SOURCES_DIR}/PermissionsVerifierF.h
   ${GENERATED_GLACIER2_SOURCES_DIR}/Router.h
   ${GENERATED_GLACIER2_SOURCES_DIR}/RouterF.h
   ${GENERATED_GLACIER2_SOURCES_DIR}/SSLInfo.h
   ${GENERATED_GLACIER2_SOURCES_DIR}/Session.h
)

set(GENERATED_GLACIER2_SOURCES
   ${GENERATED_GLACIER2_SOURCES_DIR}/Metrics.cpp
   ${GENERATED_GLACIER2_SOURCES_DIR}/PermissionsVerifier.cpp
   ${GENERATED_GLACIER2_SOURCES_DIR}/PermissionsVerifierF.cpp
   ${GENERATED_GLACIER2_SOURCES_DIR}/Router.cpp
   ${GENERATED_GLACIER2_SOURCES_DIR}/RouterF.cpp
   ${GENERATED_GLACIER2_SOURCES_DIR}/SSLInfo.cpp
   ${GENERATED_GLACIER2_SOURCES_DIR}/Session.cpp
)

set_source_files_properties(
   ${GENERATED_GLACIER2_HEADERS}
   ${GENERATED_GLACIER2_SOURCES} 
   PROPERTIES 
      GENERATED TRUE)


add_library(${GLACIER2_TARGET_NAME})

target_sources(${GLACIER2_TARGET_NAME}
   PRIVATE
      Application.cpp
      ${PROJECT_SOURCE_DIR}/cpp/include/Glacier2/Application.h
      ${PROJECT_SOURCE_DIR}/cpp/include/Glacier2/Config.h
      ${PROJECT_SOURCE_DIR}/cpp/include/Glacier2/Glacier2.h
      NullPermissionsVerifier.cpp
      ${PROJECT_SOURCE_DIR}/cpp/include/Glacier2/NullPermissionsVerifier.h
      SessionHelper.cpp
      ${PROJECT_SOURCE_DIR}/cpp/include/Glacier2/SessionHelper.h
      ${GENERATED_GLACIER2_HEADERS}
      ${GENERATED_GLACIER2_SOURCES}
)

if(WIN32)
   target_sources(${GLACIER2_TARGET_NAME}
      PRIVATE
         Glacier2.rc
   )
endif()

target_include_directories(${GLACIER2_TARGET_NAME}
   PRIVATE 
      ${PROJECT_BINARY_DIR}/generated
		${PROJECT_SOURCE_DIR}/cpp/include
      ${PROJECT_SOURCE_DIR}/cpp/src
      
)

if(CMAKE_CXX_STANDARD EQUAL 11)
	set(GLACIER2_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
else()
	set(GLACIER2_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS")
endif()

target_compile_definitions(${GLACIER2_TARGET_NAME} 
   PRIVATE 
      ${GLACIER2_COMPILE_DEFS}
)

if(BUILD_SHARED_LIBS)
   target_compile_definitions(${GLACIER2_TARGET_NAME}
      PRIVATE
         "GLACIER2_API_EXPORTS"
   )   
endif()

target_compile_options(${GLACIER2_TARGET_NAME} 
   PRIVATE
      ${ICE_COMPILE_OPTIONS}   
)

add_dependencies(${GLACIER2_TARGET_NAME} ${ICE_TARGET_NAME})

if(WIN32)
   source_group(
      TREE ${CMAKE_CURRENT_SOURCE_DIR}
      PREFIX "Resource Files"
      FILES
         ${CMAKE_CURRENT_SOURCE_DIR}/Glacier2.rc
   )

   source_group(
      TREE ${GENERATED_GLACIER2_SOURCES_DIR}
      PREFIX "Header Files/Generated"
      FILES
         ${GENERATED_GLACIER2_HEADERS}
   )

   source_group(
      TREE ${GENERATED_GLACIER2_SOURCES_DIR}
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
endif()

foreach(slice ${GLACIER2_SLICES})
	#function(CompileSlices slice2_bin slice_path ice_file slice_target output_dir)
	CompileSlices(slice2cpp
		${SLICE_DIR}
		${slice}
		${GLACIER2_TARGET_NAME}
		${GENERATED_GLACIER2_SOURCES_DIR}
	)
endforeach()
