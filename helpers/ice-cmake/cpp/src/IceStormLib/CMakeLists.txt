if(NOT ${PROJECT_BINARY_DIR}/generated/IceStorm)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceStorm)
endif()

set(GENERATED_ICESTORM_SOURCES_DIR
    ${PROJECT_BINARY_DIR}/generated/IceStorm
)

set(ICESTORM_SLICES
    ${SLICE_DIR}/IceStorm/IceStorm.ice
    ${SLICE_DIR}/IceStorm/Metrics.ice
)

set(GENERATED_ICESTORM_HEADERS
    ${GENERATED_ICESTORM_SOURCES_DIR}/IceStorm.h
    ${GENERATED_ICESTORM_SOURCES_DIR}/Metrics.h
)

set(GENERATED_ICESTORM_SOURCES
    ${GENERATED_ICESTORM_SOURCES_DIR}/IceStorm.cpp
    ${GENERATED_ICESTORM_SOURCES_DIR}/Metrics.cpp
)

set_source_files_properties(
    ${GENERATED_ICESTORM_HEADERS}
    ${GENERATED_ICESTORM_SOURCES}
    PROPERTIES
        GENERATED TRUE
)

add_library(icestorm)

add_dependencies(icestorm ice)

target_sources(icestorm
    PRIVATE
        ${GENERATED_ICESTORM_HEADERS}
        ${GENERATED_ICESTORM_SOURCES}
)

target_include_directories(icestorm
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(icestorm
    PRIVATE
        ${ICE_COMPILE_DEFS}
        "ICESTORM_API_EXPORTS"
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceStorm.rc
    )

    source_group(
        TREE ${GENERATED_ICESTORM_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICESTORM_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICESTORM_SOURCES_DIR}
        PREFIX "Source Files/Generated"
        FILES
            ${GENERATED_ICESTORM_SOURCES}
    )

    source_group(
        TREE ${SLICE_DIR}/IceStorm
        PREFIX "Slice Files"
        FILES
            ${ICESTORM_SLICES}
    )

    target_sources(icestorm
        PRIVATE
            IceStorm.rc
    )

    target_compile_options(icestorm 
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}   
    )

    target_compile_definitions(icestorm
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )
endif()

foreach(slice ${ICESTORM_SLICES})
    #function(CompileSlices slice2_bin slice_path ice_file slice_target include_dir output_dir)
    CompileSlices(slice2cpp
        ${SLICE_DIR}
        ${slice}
        icestorm
        IceStorm
        ${GENERATED_ICESTORM_SOURCES_DIR}
    )
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
    set_target_properties(icestorm 
        PROPERTIES
            OUTPUT_NAME icestorm${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
    )
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set_target_properties(icestorm 
        PROPERTIES
            OUTPUT_NAME icestorm${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
    )
endif()

install(TARGETS icestorm DESTINATION lib)
