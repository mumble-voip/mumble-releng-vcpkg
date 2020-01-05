if(CMAKE_CXX_STANDARD EQUAL 98)
    if(NOT ${GENERATED_SLICES_DIR}/IceGrid)
        file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid)
    endif()

    set(ICEGRIDADMIN_SLICES
        ${CMAKE_CURRENT_SOURCE_DIR}/Internal.ice
    )

    set(GENERATED_ICEGRIDADMIN_HEADERS
        ${GENERATED_SLICES_DIR}/IceGrid/Internal.h
    )

    set(GENERATED_ICEGRIDADMIN_SOURCES
        ${GENERATED_SLICES_DIR}/IceGrid/Internal.cpp
    )

    add_executable(icegridadmin)

    add_dependencies(icegridadmin icebox)

    target_sources(icegridadmin
        PRIVATE
            Client.cpp
            DescriptorBuilder.cpp
            DescriptorHelper.cpp
            DescriptorParser.cpp
            FileParserI.cpp
            Grammar.cpp
            Parser.cpp
            Scanner.cpp
            Util.cpp
            ${GENERATED_ICEGRIDADMIN_HEADERS}
            ${GENERATED_ICEGRIDADMIN_SOURCES}
    )

    target_include_directories(icegridadmin
        PRIVATE
            ${GENERATED_SLICES_DIR}
            ${PROJECT_SOURCE_DIR}/cpp/include
            ${PROJECT_SOURCE_DIR}/cpp/src
    )

    target_compile_definitions(icegridadmin
        PRIVATE
            ${ICE_COMPILE_DEFS}
    )

    target_link_libraries(icegridadmin
        PRIVATE
            icegrid
            icelocatordiscovery
            icepatch2
            icexml
            iceboxlib
            ice
            glacier2
            ${BZIP2_LIBRARIES}
            EXPAT::EXPAT
    )

    if(WIN32)
        source_group(
            TREE ${CMAKE_CURRENT_SOURCE_DIR}
            PREFIX "Resource Files"
            FILES
                IceGridAdmin.rc
        )

        source_group(
            TREE ${GENERATED_SLICES_DIR}/IceGrid
            PREFIX "Header Files/Generated"
            FILES
                ${GENERATED_ICEGRIDADMIN_HEADERS}
        )

        source_group(
            TREE ${GENERATED_SLICES_DIR}/IceGrid
            PREFIX "Source Files/Generated"
            FILES
                ${GENERATED_ICEGRIDADMIN_SOURCES}
        )

        source_group(
            TREE ${CMAKE_CURRENT_SOURCE_DIR}
            PREFIX "Slice Files"
            FILES 
                Internal.ice
        )

        target_sources(icegridadmin
            PRIVATE
                IceGridAdmin.rc
        )

        target_compile_options(icegridadmin
            PRIVATE
                ${ICE_WIN32_COMPILE_OPTIONS}
        )

        target_compile_definitions(icegridadmin
            PRIVATE
                ${ICE_WIN32_COMPILE_DEFS}
        )

        target_link_options(icegridadmin
            PRIVATE
                ${ICE_WIN32_LINK_OPTIONS}
        )

        target_link_libraries(icegridadmin
            PRIVATE
                advapi32.lib
                ws2_32.lib
                Iphlpapi.lib
                rpcrt4.lib
                DbgHelp.lib
                Shlwapi.lib
        )
    endif()

    list(APPEND ICEGRIDADMIN_SLICE_DIRS "-I${SLICE_DIR}")
    list(APPEND ICEGRIDADMIN_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceGrid")

    foreach(slice ${ICEGRIDADMIN_SLICES})
        get_filename_component(slice_name ${slice} NAME_WE)
        #function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_file)
        CompileSlice(slice2cpp
            "${ICEGRIDADMIN_SLICE_PARAMS}"
            "${ICEGRIDADMIN_SLICE_DIRS}"
            ${slice}
            ${GENERATED_SLICES_DIR}/IceGrid
            ${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.cpp
            ${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.h
        )
    endforeach()

    install(DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid DESTINATION generated)
    install(TARGETS icegridadmin DESTINATION bin)

    if(NOT ${GENERATED_SLICES_DIR}/IceGrid)
        file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid)
    endif()

    set(ICEGRIDNODE_SLICES
        ${CMAKE_CURRENT_SOURCE_DIR}/Internal.ice
        ${SLICE_DIR}/IceLocatorDiscovery/IceLocatorDiscovery.ice
    )

    set(GENERATED_ICEGRIDNODE_HEADERS
        ${GENERATED_SLICES_DIR}/IceGrid/IceLocatorDiscovery.h
        ${GENERATED_SLICES_DIR}/IceGrid/Internal.h
    )

    set(GENERATED_ICEGRIDNODE_SOURCES
        ${GENERATED_SLICES_DIR}/IceGrid/IceLocatorDiscovery.cpp
        ${GENERATED_SLICES_DIR}/IceGrid/Internal.cpp
    )

    add_executable(icegridnode)

    target_sources(icegridnode
        PRIVATE
            Activator.cpp
            AdapterCache.cpp
            AdminCallbackRouter.cpp
            AdminI.cpp
            AdminRouter.cpp
            AdminSessionI.cpp
            Allocatable.cpp
            AllocatableObjectCache.cpp
            Database.cpp
            DescriptorBuilder.cpp
            DescriptorHelper.cpp
            DescriptorParser.cpp
            FileCache.cpp
            FileUserAccountMapperI.cpp
            IceGridNode.cpp
            InternalRegistryI.cpp
            LocatorI.cpp
            LocatorRegistryI.cpp
            NodeAdminRouter.cpp
            NodeCache.cpp
            NodeI.cpp
            NodeSessionI.cpp
            NodeSessionManager.cpp
            ObjectCache.cpp
            PlatformInfo.cpp
            PluginFacadeI.cpp
            QueryI.cpp
            ReapThread.cpp
            RegistryAdminRouter.cpp
            RegistryI.cpp
            ReplicaCache.cpp
            ReplicaSessionI.cpp
            ReplicaSessionManager.cpp
            ServerAdapterI.cpp
            ServerCache.cpp
            ServerI.cpp
            SessionI.cpp
            SessionManager.cpp
            SessionServantManager.cpp
            Topics.cpp
            TraceLevels.cpp
            Util.cpp
            WellKnownObjectsManager.cpp
            ${GENERATED_ICEGRIDNODE_HEADERS}
            ${GENERATED_ICEGRIDNODE_SOURCES}
            ${ICEGRIDNODE_SLICES}
    )

    target_include_directories(icegridnode
        PRIVATE
            ${GENERATED_SLICES_DIR}
            ${PROJECT_SOURCE_DIR}/cpp/include
            ${PROJECT_SOURCE_DIR}/cpp/src
    )

    target_compile_definitions(icegridnode
        PRIVATE
            ${ICE_COMPILE_DEFS}
    )

    target_link_libraries(icegridnode
        PRIVATE
            iceutil
            glacier2
            ice
            iceboxlib
            icedb
            icegrid
            icepatch2
            icessl
            icestormservice
            icexml
            ${BZIP2_LIBRARIES}
            EXPAT::EXPAT
    )
    
    target_link_libraries(icegridnode
        PRIVATE
            lmdb
    )

    if(WIN32)
        source_group(
            TREE ${CMAKE_CURRENT_SOURCE_DIR}
            PREFIX "Resource Files"
            FILES
                IceGridNode.rc
        )

        source_group("Header Files/Generated"
            FILES
                ${GENERATED_ICEGRIDNODE_HEADERS}
        )

        source_group("Source Files/Generated"
            FILES
                ${GENERATED_ICEGRIDNODE_SOURCES}
        )

        source_group("Slice Files"
            FILES 
                ${ICEGRIDNODE_SLICES}
        )

        target_sources(icegridnode
            PRIVATE
                IceGridNode.rc
        )

        target_compile_options(icegridnode
            PRIVATE
                ${ICE_WIN32_COMPILE_OPTIONS}
        )

        target_compile_definitions(icegridnode
            PRIVATE
                ${ICE_WIN32_COMPILE_DEFS}
        )

        target_link_options(icegridnode
            PRIVATE
                ${ICE_WIN32_LINK_OPTIONS}
        )

        target_link_libraries(icegridnode
            PRIVATE
                advapi32.lib
                crypt32.lib
                ws2_32.lib
                Iphlpapi.lib
                rpcrt4.lib
                DbgHelp.lib
                pdh.lib
                secur32.lib
                Shlwapi.lib
                version.lib
        )
    endif()

    list(APPEND ICEGRIDNODE_SLICE_DIRS "-I${SLICE_DIR}")
    list(APPEND ICEGRIDNODE_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceGrid")

    foreach(slice ${ICEGRIDNODE_SLICES})
        get_filename_component(slice_name ${slice} NAME_WE)
        #function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_file)
        CompileSlice(slice2cpp
            "${ICEGRIDNODE_SLICE_PARAMS}"
            "${ICEGRIDNODE_SLICE_DIRS}"
            ${slice}
            ${GENERATED_SLICES_DIR}/IceGrid
            ${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.cpp
            ${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.h
        )
    endforeach()

    install(DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid DESTINATION generated)
    install(TARGETS icegridnode DESTINATION bin)

endif()
