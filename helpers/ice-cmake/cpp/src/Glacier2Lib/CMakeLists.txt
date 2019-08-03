
add_library(glacier2)

set(GENERATED_GLACIER2_SOURCES

)

set_source_files_properties(${GENERATED_GLACIER2_SOURCES} PROPERTIES GENERATED TRUE)

target_sources(glacier2
   PRIVATE
      ${GENERATED_GLACIER2_SOURCES}
      Application.cpp
      Glacier2.rc
      NullPermissionsVerifier.cpp
      SessionHelper.cpp
)

target_include_directories(glacier2
   PRIVATE 
      ${CMAKE_SOURCE_DIR}/include
	   ${CMAKE_SOURCE_DIR}/src
      ${GENERATED_SOURCE_DIR}
      ${GENERATED_SOURCE_DIR}/Glacier2
)

if(CMAKE_CXX_STANDARD EQUAL 11)
	set(GLACIER2LIB_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
else()
	set(GLACIER2LIB_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS")
endif()

target_compile_definitions(glacier2 PRIVATE 
   #"GLACIER2_API_EXPORTS"
   ${GLACIER2LIB_COMPILE_DEFS}
)

target_compile_options(glacier2 PRIVATE
   ${ICE_COMPILE_OPTIONS}   
)

target_link_libraries(glacier2 PRIVATE ice)

#function(CompileSlices slice2_bin slice_path slice_dir slice_target output_dir lang_std)
CompileSlices(slice2cpp
   ${SLICE_DIR}
   Glacier2
   glacier2
   ${GENERATED_SOURCE_DIR}/Glacier2
   --impl-c++${CMAKE_CXX_STANDARD}
)
