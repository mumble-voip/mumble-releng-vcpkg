if(NOT ${PROJECT_BINARY_DIR}/generated/Glacier2)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/Glacier2)
endif()

set(GENERATED_GLACIER2ROUTER_SOURCES_DIR 
    ${PROJECT_BINARY_DIR}/generated/Glacier2
)

set(GLACIER2ROUTER_SLICES
    ${CMAKE_CURRENT_SOURCE_DIR}/Instrumentation.ice
)

set(GENERATED_GLACIER2ROUTER_HEADERS
    ${GENERATED_GLACIER2ROUTER_SOURCES_DIR}/Instrumentation.h
)

set(GENERATED_GLACIER2ROUTER_SOURCES
    ${GENERATED_GLACIER2ROUTER_SOURCES_DIR}/Instrumentation.cpp
)

set_source_files_properties(
    ${GENERATED_GLACIER2ROUTER_HEADERS}
    ${GENERATED_GLACIER2ROUTER_SOURCES}
    PROPERTIES
        GENERATED TRUE
)

add_executable(glacier2router)

target_sources(glacier2router
    PRIVATE
        Blobject.cpp
        Blobject.h
        ClientBlobject.cpp
        ClientBlobject.h
        FilterI.cpp
        FilterI.h
        FilterManager.cpp
        FilterManager.h
        Glacier2Router.cpp
        Instance.cpp
        Instance.h
        Instrumentation.ice
        InstrumentationI.cpp
        InstrumentationI.h
        ProxyVerifier.cpp
        ProxyVerifier.h
        RequestQueue.cpp
        RequestQueue.h
        RouterI.cpp
        RouterI.h
        RoutingTable.cpp
        RoutingTable.h
        ServerBlobject.cpp
        ServerBlobject.h
        SessionRouterI.cpp
        SessionRouterI.h
        ${GENERATED_GLACIER2ROUTER_HEADERS}
        ${GENERATED_GLACIER2ROUTER_SOURCES}
)

target_include_directories(glacier2router
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src    
)

target_compile_definitions(glacier2router
    PRIVATE
        ${ICE_COMPILE_DEFS}
)

target_link_libraries(glacier2router
    PRIVATE
        ice
        glacier2
        icessl
        ${BZIP2_LIBRARIES}
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            Glacier2Router.rc
    )

    source_group(
        TREE ${GENERATED_GLACIER2ROUTER_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_GLACIER2ROUTER_HEADERS}
    )

    source_group(
        TREE ${GENERATED_GLACIER2ROUTER_SOURCES_DIR}
        PREFIX "Source Files/Generated"
        FILES
            ${GENERATED_GLACIER2ROUTER_SOURCES}
    )

    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Slice Files"
        FILES
            ${GLACIER2ROUTER_SLICES}
    )

    target_sources(glacier2router
        PRIVATE
            Glacier2Router.rc
    )

    target_compile_options(glacier2router 
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}   
    )

    target_compile_definitions(glacier2router
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )

    target_link_options(glacier2router
        PRIVATE
            ${ICE_WIN32_LINK_OPTIONS}
    )

    target_link_libraries(glacier2router
        PRIVATE
            advapi32.lib
            ws2_32.lib
            Iphlpapi.lib
            rpcrt4.lib
            DbgHelp.lib
            Shlwapi.lib
    )

endif()

list(APPEND GLACIER2ROUTERS_SLICE_DIRS "-I${SLICE_DIR}")

foreach(slice ${GLACIER2ROUTER_SLICES})
    #function(CompileSlice slice2_bin slice_include_paths ice_file slice_target include_dir output_dir)
    CompileSlice(slice2cpp
        ${GLACIER2ROUTER_SLICE_DIRS}
        ${slice}
        glacier2router
        Glacier2
        ${GENERATED_GLACIER2ROUTER_SOURCES_DIR}
    )
endforeach()

install(TARGETS glacier2router DESTINATION bin)
