if(CMAKE_CXX_STANDARD EQUAL 11)
	set(GLACIER2_PROJECT_NAME glacier2++11)
elseif(CMAKE_CXX_STANDARD EQUAL 98)
	set(GLACIER2_PROJECT_NAME glacier)
endif()

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


add_library(${GLACIER2_PROJECT_NAME})

target_sources(${GLACIER2_PROJECT_NAME}
   PRIVATE
      ${GENERATED_GLACIER2_SOURCES}
      Application.cpp
      Glacier2.rc
      NullPermissionsVerifier.cpp
      SessionHelper.cpp
)

target_include_directories(${GLACIER2_PROJECT_NAME}
   PRIVATE 
      ${PROJECT_BINARY_DIR}/generated
      ${CMAKE_SOURCE_DIR}/include
	   ${CMAKE_SOURCE_DIR}/src
)

if(CMAKE_CXX_STANDARD EQUAL 11)
	set(GLACIER2_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
else()
	set(GLACIER2_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS")
endif()

target_compile_definitions(glacier2 
   PRIVATE 
      ${GLACIER2_COMPILE_DEFS}
      "GLACIER2_API_EXPORTS"
)

target_compile_options(glacier2 
   PRIVATE
      ${ICE_COMPILE_OPTIONS}   
)

find_package(OpenSSL REQUIRED)

add_dependencies(glacier2 ice)

if(WIN32)
   source_group(
      TREE ${CMAKE_CURRENT_SOURCE_DIR}
      PREFIX "Resource Files"
      FILES
         ${CMAKE_CURRENT_SOURCE_DIR}/Glacier2.rc
   )
endif()

# #function(CompileSlices slice2_bin slice_path slice_dir slice_target output_dir lang_std)
# CompileSlices(slice2cpp
#    ${SLICE_DIR}
#    Glacier2
#    glacier2
#    ${GENERATED_SOURCE_DIR}/Glacier2
#    --impl-c++${CMAKE_CXX_STANDARD}
# )
