if(NOT ${PROJECT_BINARY_DIR}/generated/IceLocatorDiscovery)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceLocatorDiscovery)
endif()

set(GENERATED_ICELOCATORDISCOVERY_SOURCES_DIR
    ${PROJECT_BINARY_DIR}/generated/IceLocatorDiscovery
)

set(ICELOCATORDISCOVERY_SLICES
    ${SLICE_DIR}/IceLocatorDiscovery/IceLocatorDiscovery.ice
)

set(GENERATED_ICELOCATORDISCOVERY_HEADERS
    ${GENERATED_ICELOCATORDISCOVERY_SOURCES_DIR}/IceLocatorDiscovery.h
)

set(GENERATED_ICELOCATORDISCOVERY_SOURCES
    ${GENERATED_ICELOCATORDISCOVERY_SOURCES_DIR}/IceLocatorDiscovery.cpp
)

set_source_files_properties(
    ${GENERATED_ICELOCATORDISCOVERY_HEADERS}
    ${GENERATED_ICELOCATORDISCOVERY_SOURCES}
    PROPERTIES
        GENERATED TRUE
)

add_library(icelocatordiscovery)

add_dependencies(icelocatordiscovery ice)

target_sources(icelocatordiscovery
    PRIVATE
        Plugin.h
        PluginI.cpp
        ${GENERATED_ICELOCATORDISCOVERY_HEADERS}
        ${GENERATED_ICELOCATORDISCOVERY_SOURCES}
        ${ICELOCATORDISCOVERY_SLICES}
)

target_include_directories(icelocatordiscovery
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src    
)

if(CMAKE_CXX_STANDARD EQUAL 11)
    set(ICELOCATORDISCOVERY_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set(ICELOCATORDISCOVERY_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS}")
endif()

target_compile_definitions(icelocatordiscovery
    PRIVATE
        ${ICELOCATORDISCOVERY_COMPILE_DEFS}
        "ICE_LOCATOR_DISCOVERY_API_EXPORTS"
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceLocatorDiscovery.rc
    )

    source_group(
        TREE ${GENERATED_ICELOCATORDISCOVERY_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICELOCATORDISCOVERY_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICELOCATORDISCOVERY_SOURCES_DIR}
        PREFIX "Source Files/Generated"
        FILES
            ${GENERATED_ICELOCATORDISCOVERY_SOURCES}
    )

    source_group(
        TREE ${SLICE_DIR}/IceLocatorDiscovery
        PREFIX "Slice Files"
        FILES
            ${ICELOCATORDISCOVERY_SLICES}
    )

    target_sources(icelocatordiscovery
        PRIVATE
            IceLocatorDiscovery.rc
    )

    target_compile_options(icelocatordiscovery 
        PRIVATE
            ${ICE_COMPILE_OPTIONS}   
    )
endif()

foreach(slice ${ICELOCATORDISCOVERY_SLICES})
    #function(CompileSlices slice2_bin slice_path ice_file slice_target include_dir output_dir)
    CompileSlices(slice2cpp
        ${SLICE_DIR}
        ${slice}
        icelocatordiscovery
        IceLocatorDiscovery
        ${GENERATED_ICELOCATORDISCOVERY_SOURCES_DIR}
    )
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
    set_target_properties(icelocatordiscovery 
        PROPERTIES
            OUTPUT_NAME icelocatordiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
    )
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set_target_properties(icelocatordiscovery 
        PROPERTIES
            OUTPUT_NAME icelocatordiscovery${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
    )
endif()

install(TARGETS icelocatordiscovery DESTINATION lib)
