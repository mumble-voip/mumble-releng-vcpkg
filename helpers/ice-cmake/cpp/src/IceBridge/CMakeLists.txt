add_executable(icebridge)

add_dependencies(icebridge ice)

target_sources(icebridge
    PRIVATE
        IceBridge.cpp
)

target_include_directories(icebridge
    PRIVATE
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(icebridge
    PRIVATE
        ${ICE_COMPILE_DEFS}
)

if(WIN32)
    target_sources(icebridge
        PRIVATE
            IceBridge.rc
    )

    target_compile_options(icebridge
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}
    )

    target_compile_definitions(icebridge
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )

    target_link_options(icebridge
        PRIVATE
            ${ICE_WIN32_LINK_OPTIONS}
    )

    target_link_libraries(icebridge
        PRIVATE
            advapi32.lib
            ws2_32.lib
            Iphlpapi.lib
            rpcrt4.lib
            DbgHelp.lib
            Shlwapi.lib
    )

    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceBridge.rc
    )

endif()

install(TARGETS icebridge DESTINATION bin)
