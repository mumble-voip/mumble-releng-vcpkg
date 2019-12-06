if(NOT ${PROJECT_BINARY_DIR}/generated/IceDiscovery)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceDiscovery)
endif()

set(GENERATED_ICEDISCOVERY_SOURCES_DIR
    ${PROJECT_BINARY_DIR}/generated/IceDiscovery
)

set(ICEDISCOVERY_SLICES
    ${SLICE_DIR}/IceDiscovery/IceDiscovery.ice
)

set(GENERATED_ICEDISCOVERY_HEADERS
    ${GENERATED_ICEDISCOVERY_SOURCES_DIR}/IceDiscovery.h
)

set(GENERATED_ICEDISCOVERY_SOURCES
    ${GENERATED_ICEDISCOVERY_SOURCES_DIR}IceDiscovery.cpp
)

set_source_files_properties(
    ${GENERATED_ICEDISCOVERY_HEADERS}
    ${GENERATED_ICEDISCOVERY_SOURCES}
    PROPERTIES
        GENERATED TRUE
)

add_library(icediscovery)

target_sources(icediscovery
    PRIVATE
        LocatorI.cpp
        LocatorI.h
        LookupI.cpp
        LookupI.h
        PluginI.cpp
        PluginI.h
)

target_include_directories(icediscovery
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src    
)

if(CMAKE_CXX_STANDARD EQUAL 11)
    set(ICEDISCOVERY_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set(ICEDISCOVERY_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS}")
endif()

target_compile_definitions(icediscovery
    PRIVATE
        ${ICEDISCOVERY_COMPILE_DEFS}
        "ICEDISCOVERY_API_EXPORTS"
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            ${CMAKE_CURRENT_SOURCE_DIR}/IceDiscovery.rc
    )

    source_group(
        TREE ${GENERATED_ICEDISCOVERY_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICEDISCOVERY_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICEDISCOVERY_SOURCES_DIR}
        PREFIX "Source Files/Generated"
        FILES
            ${GENERATED_ICEDISCOVERY_SOURCES}
    )

    source_group(
        TREE ${SLICE_DIR}/IceDiscovery
        PREFIX "Slice Files"
        FILES
            ${ICEDISCOVERY_SLICES}
    )

    target_sources(icediscovery
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/IceDiscovery.rc
    )

    target_compile_options(icediscovery 
    PRIVATE
        ${ICE_COMPILE_OPTIONS}   
    )
endif()

foreach(slice ${ICEDISCOVERY_SLICES})
    #function(CompileSlices slice2_bin slice_path ice_file slice_target include_dir output_dir)
    CompileSlices(slice2cpp
        ${SLICE_DIR}
        ${slice}
        icediscovery
        IceDiscovery
        ${GENERATED_ICEDISCOVERY_SOURCES_DIR}
    )
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
    set_target_properties(icediscovery 
        PROPERTIES
            OUTPUT_NAME icediscovery++11
    )
endif()

install(TARGETS icediscovery DESTINATION lib)
