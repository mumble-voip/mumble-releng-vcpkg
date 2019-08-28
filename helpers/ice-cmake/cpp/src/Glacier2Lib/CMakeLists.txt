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

add_library(${GLACIER2_PROJECT_NAME})

# set(GENERATED_GLACIER2_SOURCES

# )

#set_source_files_properties(${GENERATED_GLACIER2_SOURCES} PROPERTIES GENERATED TRUE)

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
	set(GLACIER2LIB_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
else()
	set(GLACIER2LIB_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS")
endif()

target_compile_definitions(glacier2 
   PRIVATE 
      ${GLACIER2LIB_COMPILE_DEFS}
      "GLACIER2_API_EXPORTS"
)

target_compile_options(glacier2 
   PRIVATE
      ${ICE_COMPILE_OPTIONS}   
)

add_dependencies(glacier2 ice)

# #function(CompileSlices slice2_bin slice_path slice_dir slice_target output_dir lang_std)
# CompileSlices(slice2cpp
#    ${SLICE_DIR}
#    Glacier2
#    glacier2
#    ${GENERATED_SOURCE_DIR}/Glacier2
#    --impl-c++${CMAKE_CXX_STANDARD}
# )
