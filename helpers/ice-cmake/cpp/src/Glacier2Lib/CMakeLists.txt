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
        GENERATED TRUE
)


add_library(glacier2)

add_dependencies(glacier2 ice)

target_sources(glacier2
    PRIVATE
        Application.cpp
        NullPermissionsVerifier.cpp
        SessionHelper.cpp
        ${GENERATED_GLACIER2_HEADERS}
        ${GENERATED_GLACIER2_SOURCES}
)

target_include_directories(glacier2
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src    
)

target_compile_definitions(glacier2 
    PRIVATE 
        ${ICE_COMPILE_DEFS}
        "GLACIER2_API_EXPORTS"
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            Glacier2.rc
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

    target_sources(glacier2
        PRIVATE
            Glacier2.rc
    )

    target_compile_options(glacier2 
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}   
    )

    target_compile_definitions(glacier2
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )
endif()

foreach(slice ${GLACIER2_SLICES})
    #function(CompileSlices slice2_bin slice_path ice_file slice_target include_dir output_dir)
    CompileSlices(slice2cpp
        ${SLICE_DIR}
        ${slice}
        glacier2
        Glacier2
        ${GENERATED_GLACIER2_SOURCES_DIR}
    )
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
    set_target_properties(glacier2 
        PROPERTIES
            OUTPUT_NAME glacier2${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
    )
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set_target_properties(glacier2 
        PROPERTIES
            OUTPUT_NAME glacier2${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
    )
endif()

install(TARGETS glacier2 DESTINATION lib)
