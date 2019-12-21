if(NOT ${PROJECT_BINARY_DIR}/generated/IcePatch2)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IcePatch2)
endif()

set(GENERATED_ICEPATCH2_SOURCES_DIR
    ${PROJECT_BINARY_DIR}/generated/IcePatch2
)

set(ICEPATCH2_SLICES
    ${SLICE_DIR}/IcePatch2/FileInfo.ice
    ${SLICE_DIR}/IcePatch2/FileServer.ice
)

set(GENERATED_ICEPATCH2_HEADERS
    ${GENERATED_ICEPATCH2_SOURCES_DIR}/FileInfo.h
    ${GENERATED_ICEPATCH2_SOURCES_DIR}/FileServer.h
)

set(GENERATED_ICEPATCH2_SOURCES
    ${GENERATED_ICEPATCH2_SOURCES_DIR}/FileInfo.cpp
    ${GENERATED_ICEPATCH2_SOURCES_DIR}/FileServer.cpp
)

set_source_files_properties(
    ${GENERATED_ICEPATCH2_HEADERS}
    ${GENERATED_ICEPATCH2_SOURCES}
    PROPERTIES
        GENERATED TRUE
)

add_library(icepatch2)

add_dependencies(icepatch2 ice)

target_sources(icepatch2
    PRIVATE
        ClientUtil.cpp
        Util.cpp
        Util.h
        ${GENERATED_ICEPATCH2_HEADERS}
        ${GENERATED_ICEPATCH2_SOURCES}
        ${ICEPATCH2_SLICES}
)

target_include_directories(icepatch2
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
        ${BZIP2_INCLUDE_DIR} 
)

target_compile_definitions(icepatch2
    PRIVATE
        ${ICE_COMPILE_DEFS}
        "ICEPATCH2_API_EXPORTS"
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IcePatch2.rc
    )

    source_group(
        TREE ${GENERATED_ICEPATCH2_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICEPATCH2_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICEPATCH2_SOURCES_DIR}
        PREFIX "Source Files/Generated"
        FILES
            ${GENERATED_ICEPATCH2_SOURCES}
    )

    source_group(
        TREE ${SLICE_DIR}/IcePatch2
        PREFIX "Slice Files"
        FILES
            ${ICEPATCH2_SLICES}
    )

    target_sources(icepatch2
        PRIVATE
            IcePatch2.rc
    )

    target_compile_options(icepatch2
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}   
    )

    target_compile_definitions(icepatch2
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )
endif()

list(APPEND ICEPATCH2_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICEPATCH2_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IcePatch2")

foreach(slice ${ICEPATCH2_SLICES})
    #function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file slice_target output_dir)
    CompileSlice(slice2cpp
        "${ICEPATCH2_SLICE_DIRS}"
        "${ICEPATCH2_SLICE_PARAMS}"
        ${slice}
        icepatch2
        ${GENERATED_ICEPATCH2_SOURCES_DIR}
    )
endforeach()

set_target_properties(icepatch2
    PROPERTIES
        OUTPUT_NAME icepatch2${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
)

install(TARGETS icepatch2 DESTINATION lib)
