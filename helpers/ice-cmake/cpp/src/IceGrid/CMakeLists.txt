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

# TODO - find out if these are for test or for other os's

# target_sources(icegrid
#     PRIVATE
#         Activator.cpp
#         Activator.h
#         AdapterCache.cpp
#         AdapterCache.h
#         AdminCallbackRouter.cpp
#         AdminCallbackRouter.h
#         AdminI.cpp
#         AdminI.h
#         AdminRouter.cpp
#         AdminRouter.h
#         AdminSessionI.cpp
#         AdminSessionI.h
#         Allocatable.cpp
#         Allocatable.h
#         AllocatableObjectCache.cpp
#         AllocatableObjectCache.h
#         Cache.h
#         Client.cpp
#         Database.cpp
#         Database.h
#         DescriptorBuilder.cpp
#         DescriptorBuilder.h
#         DescriptorHelper.cpp
#         DescriptorHelper.h
#         DescriptorParser.cpp
#         DescriptorParser.h
#         FileCache.cpp
#         FileCache.h
#         FileParserI.cpp
#         FileParserI.h
#         FileUserAccountMapperI.cpp
#         FileUserAccountMapperI.h
#         Grammar.cpp
#         Grammar.h
#         IceGridNode.cpp
#         IceGridRegistry.cpp
#         Internal.ice
#         InternalRegistryI.cpp
#         InternalRegistryI.h
#         LocatorI.cpp
#         LocatorI.h
#         LocatorRegistryI.cpp
#         LocatorRegistryI.h
#         NodeAdminRouter.cpp
#         NodeAdminRouter.h
#         NodeCache.cpp
#         NodeCache.h
#         NodeI.cpp
#         NodeI.h
#         NodeSessionI.cpp
#         NodeSessionI.h
#         NodeSessionManager.cpp
#         NodeSessionManager.h
#         ObjectCache.cpp
#         ObjectCache.h
#         Parser.cpp
#         Parser.h
#         PlatformInfo.cpp
#         PlatformInfo.h
#         PluginFacadeI.cpp
#         PluginFacadeI.h
#         QueryI.cpp
#         QueryI.h
#         ReapThread.cpp
#         ReapThread.h
#         RegistryAdminRouter.cpp
#         RegistryAdminRouter.h
#         RegistryI.cpp
#         RegistryI.h
#         ReplicaCache.cpp
#         ReplicaCache.h
#         ReplicaSessionI.cpp
#         ReplicaSessionI.h
#         ReplicaSessionManager.cpp
#         ReplicaSessionManager.h
#         Scanner.cpp
#         ServerAdapterI.cpp
#         ServerAdapterI.h
#         ServerCache.cpp
#         ServerCache.h
#         ServerI.cpp
#         ServerI.h
#         SessionI.cpp
#         SessionI.h
#         SessionManager.cpp
#         SessionManager.h
#         SessionServantManager.cpp
#         SessionServantManager.h
#         Topics.cpp
#         Topics.h
#         TraceLevels.cpp
#         TraceLevels.h
#         Util.cpp
#         Util.h
#         WaitQueue.cpp
#         WaitQueue.h
#         WellKnownObjectsManager.cpp
#         WellKnownObjectsManager.h
#         ${GENERATED_ICEGRID_HEADERS}
#         ${GENERATED_ICEGRID_SOURCES}
#         ${ICEGRID_SLICES}
# )

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

if(CMAKE_CXX_STANDARD EQUAL 11)
    set(ICEGRID_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set(ICEGRID_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS}")
endif()

target_compile_definitions(icegrid
    PRIVATE
        ${ICEGRID_COMPILE_DEFS}
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
    #function(CompileSlices slice2_bin slice_path ice_file slice_target include_dir output_dir)
    CompileSlices(slice2cpp
        ${SLICE_DIR}
        ${slice}
        icegrid
        IceGrid
        ${GENERATED_ICEGRID_SOURCES_DIR}
    )
endforeach()

# TODO - check for other os support or test solutions
# #function(CompileSlices slice2_bin slice_path ice_file slice_target include_dir output_dir)
# CompileSlices(slice2cpp
#     ${SLICE_DIR}
#     ${CMAKE_CURRENT_SOURCE_DIR}/Internal.ice
#     icegrid
#     IceGrid
#     ${GENERATED_ICEGRID_SOURCES_DIR}
# )

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
