if(NOT ${PROJECT_BINARY_DIR}/generated/IceGrid)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceGrid)
endif()

set(GENERATED_ICEGRID_SOURCES_DIR
    ${PROJECT_BINARY_DIR}/generated/IceGrid
)

set(ICEGRID_SLICES
    ${SLICE_DIR}/IceGrid/Admin.ice
    ${SLICE_DIR}/IceGrid/Descriptor.ice
    ${SLICE_DIR}/IceGrid/Exception.ice
    ${SLICE_DIR}/IceGrid/FileParser.ice
    ${SLICE_DIR}/IceGrid/PluginFacade.ice
    ${SLICE_DIR}/IceGrid/Registry.ice
    ${SLICE_DIR}/IceGrid/Session.ice
    ${SLICE_DIR}/IceGrid/UserAccountMapper.ice
)

set(GENERATED_ICEGRID_HEADERS
    ${GENERATED_ICEGRID_SOURCES_DIR}/Admin.h
    ${GENERATED_ICEGRID_SOURCES_DIR}/Descriptor.h
    ${GENERATED_ICEGRID_SOURCES_DIR}/Exception.h
    ${GENERATED_ICEGRID_SOURCES_DIR}/FileParser.h
    ${GENERATED_ICEGRID_SOURCES_DIR}/PluginFacade.h
    ${GENERATED_ICEGRID_SOURCES_DIR}/Registry.h
    ${GENERATED_ICEGRID_SOURCES_DIR}/Session.h
    ${GENERATED_ICEGRID_SOURCES_DIR}/UserAccountMapper.h
)

set(GENERATED_ICEGRID_SOURCES
    ${GENERATED_ICEGRID_SOURCES_DIR}/Admin.cpp
    ${GENERATED_ICEGRID_SOURCES_DIR}/Descriptor.cpp
    ${GENERATED_ICEGRID_SOURCES_DIR}/Exception.cpp
    ${GENERATED_ICEGRID_SOURCES_DIR}/FileParser.cpp
    ${GENERATED_ICEGRID_SOURCES_DIR}/PluginFacade.cpp
    ${GENERATED_ICEGRID_SOURCES_DIR}/Registry.cpp
    ${GENERATED_ICEGRID_SOURCES_DIR}/Session.cpp
    ${GENERATED_ICEGRID_SOURCES_DIR}/UserAccountMapper.cpp
)

set_source_files_properties(
    ${GENERATED_ICEGRID_HEADERS}
    ${GENERATED_ICEGRID_SOURCES}
    PROPERTIES
        GENERATED TRUE
)

add_library(icegrid)

add_dependencies(icegrid glacier2)

target_sources(icegrid
    PRIVATE
        ${PROJECT_SOURCE_DIR}/cpp/src/IceGridLib/PluginFacadeI.cpp
        ${GENERATED_ICEGRID_HEADERS}
        ${GENERATED_ICEGRID_SOURCES}
        ${ICEGRID_SLICES} 
)

if(LINUX OR APPLE)
    target_sources(icegrid
        PRIVATE
            Grammar.y
            Scanner.l
    )
endif()

target_include_directories(icegrid
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src  
)

target_compile_definitions(icegrid
    PRIVATE
        ${ICE_COMPILE_DEFS}
        "ICEGRID_API_EXPORTS"
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            ${PROJECT_SOURCE_DIR}/cpp/src/IceGridLib/IceGrid.rc
    )

    source_group(
        TREE ${GENERATED_ICEGRID_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICEGRID_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICEGRID_SOURCES_DIR}
        PREFIX "Source Files/Generated"
        FILES
            ${GENERATED_ICEGRID_SOURCES}
    )

    source_group(
        TREE ${SLICE_DIR}/IceGrid
        PREFIX "Slice Files"
        FILES
            ${ICEGRID_SLICES}
    )

    target_sources(icegrid
        PRIVATE
            ${PROJECT_SOURCE_DIR}/cpp/src/IceGridLib/IceGrid.rc
    )

    target_compile_options(icegrid
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}   
    )

    target_compile_definitions(icegrid
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )
endif()

foreach(slice ${ICEGRID_SLICES})
    #function(CompileSlice slice2bin slice2bin_params slice_target output_dir)
    CompileSlice(slice2cpp
        -I${SLICE_DIR} ${slice} --include-dir IceGrid
        icegrid
        ${GENERATED_ICEGRID_SOURCES_DIR}
    )
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
    set_target_properties(icegrid 
        PROPERTIES
            OUTPUT_NAME icegrid${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
    )
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set_target_properties(icegrid 
        PROPERTIES
            OUTPUT_NAME icegrid${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
    )
endif()

install(TARGETS icegrid DESTINATION lib)

if(NOT ${PROJECT_BINARY_DIR}/generated/IceGrid)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceGrid)
endif()

set(GENERATED_ICEGRIDADMIN_SOURCES_DIR
    ${PROJECT_BINARY_DIR}/generated/IceGrid
)

set(ICEGRIDADMIN_SLICES
    ${CMAKE_CURRENT_SOURCE_DIR}/Internal.ice
)

set(GENERATED_ICEGRIDADMIN_HEADERS
    ${GENERATED_ICEGRIDADMIN_SOURCES_DIR}/Internal.h
)

set(GENERATED_ICEGRIDADMIN_SOURCES
    ${GENERATED_ICEGRIDADMIN_SOURCES_DIR}/Internal.cpp
)

set_source_files_properties(
    ${GENERATED_ICEGRIDADMIN_HEADERS}
    ${GENERATED_ICEGRIDADMIN_SOURCES}
    PROPERTIES
        GENERATED TRUE
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
        ${PROJECT_BINARY_DIR}/generated
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
        TREE ${GENERATED_ICEGRIDADMIN_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICEGRIDADMIN_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICEGRIDADMIN_SOURCES_DIR}
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

foreach(slice ${ICEGRIDADMIN_SLICES})
    #function(CompileSlice slice2bin slice2bin_params slice_target output_dir)
    CompileSlice(slice2cpp
        -I${SLICE_DIR}  ${slice} --include-dir IceGrid
        icegridadmin
        ${GENERATED_ICEGRIDADMIN_SOURCES_DIR}
    )
endforeach()

install(TARGETS icegridadmin DESTINATION bin)

if(NOT ${PROJECT_BINARY_DIR}/generated/IceGrid)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceGrid)
endif()

set(GENERATED_ICEGRIDNODE_SOURCES_DIR
    ${PROJECT_BINARY_DIR}/generated/IceLocatorDiscovery
)

set(ICEGRIDNODE_SLICES
    ${CMAKE_CURRENT_SOURCE_DIR}/Internal.ice
    ${SLICE_DIR}/IceLocatorDiscovery/IceLocatorDiscovery.ice
)

set(GENERATED_ICEGRIDNODE_HEADERS
    ${GENERATED_ICEGRIDNODE_SOURCES_DIR}/IceLocatorDiscovery.h
    ${GENERATED_ICEGRIDNODE_SOURCES_DIR}/Internal.h
)

set(GENERATED_ICEGRIDNODE_SOURCES
    ${GENERATED_ICEGRIDNODE_SOURCES_DIR}/IceLocatorDiscovery.cpp
    ${GENERATED_ICEGRIDNODE_SOURCES_DIR}/Internal.cpp
)

set_source_files_properties(
    ${GENERATED_ICEGRIDNODE_HEADERS}
    ${GENERATED_ICEGRIDNODE_SOURCES}
    PROPERTIES
        GENERATED TRUE
)

add_executable(icegridnode)

add_dependencies(icegridnode icelocatordiscovery)

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
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(icegridnode
    PRIVATE
        ${ICE_COMPILE_DEFS}
)

target_link_libraries(icegridnode
    PRIVATE
        glacier2
        iceboxlib
        icedb
        icegrid
        icepatch2
        icessl
        icestormservice
        icexml
        EXPAT::EXPAT
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceGridNode.rc
    )

    source_group(
        TREE ${GENERATED_ICEGRIDNODE_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICEGRIDNODE_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICEGRIDNODE_SOURCES_DIR}
        PREFIX "Source Files/Generated"
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
            ws2_32.lib
            Iphlpapi.lib
            rpcrt4.lib
            DbgHelp.lib
            Shlwapi.lib
    )
endif()

foreach(slice ${ICEGRIDNODE_SLICES})
    #function(CompileSlice slice2bin slice2bin_params slice_target output_dir)
    CompileSlice(slice2cpp
        -I${SLICE_DIR} ${slice} --include-dir IceGrid
        icegridnode
        ${GENERATED_ICEGRIDNODE_SOURCES_DIR}
    )
endforeach()

install(TARGETS icegridnode DESTINATION bin)
