
file(GLOB GENERATED_GLACIER2_SOURCE_NAMES 
   ${GENERATED_SOURCE_DIR}/Glacier2/*.h 
   ${GENERATED_SOURCE_DIR}/Glacier2/*.cpp
)
foreach(name ${GENERATED_GLACIER2_SOURCE_NAMES})
   list(APPEND GENERATED_GLACIER2_SOURCES ${name})
endforeach()

set_source_files_properties(${GENERATED_GLACIER2_SOURCES} PROPERTIES GENERATED TRUE)

add_library(glacier2)

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
   "GLACIER2_API_EXPORTS"
   ${GLACIER2LIB_COMPILE_DEFS}
)

target_compile_options(glacier2 PRIVATE
   ${ICE_COMPILE_OPTIONS}   
)

target_link_libraries(glacier2 PRIVATE ice)

include("${CMAKE_SOURCE_DIR}/cmake/CompileSlices.cmake")

#function(CompileSlices slice2_bin slice_path slice_folder_name slice_target output_dir)
CompileSlices(slice2cpp
   ${SLICE_DIR}
   Glacier2
   glacier2
   ${GENERATED_SOURCE_DIR}/Glacier2
   ${CMAKE_CXX_STANDARD}
)
