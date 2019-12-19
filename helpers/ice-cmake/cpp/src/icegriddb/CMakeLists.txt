if(NOT ${PROJECT_BINARY_DIR}/generated/IceGrid)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceGrid)
endif()

set(GENERATED_ICEGRIDDB_SOURCES_DIR
    ${PROJECT_BINARY_DIR}/generated/IceGrid
)

set(ICEGRIDDB_SLICES
    ${CMAKE_CURRENT_SOURCE_DIR}/DBTypes.ice
    ${SLICE_DIR}/IceGrid/Descriptor.ice
    ${SLICE_DIR}/IceGrid/Exception.ice
)

set(GENERATED_ICEGRIDDB_HEADERS
    ${GENERATED_ICEGRIDDB_SOURCES_DIR}/DBTypes.h
    ${GENERATED_ICEGRIDDB_SOURCES_DIR}/Descriptor.h
    ${GENERATED_ICEGRIDDB_SOURCES_DIR}/Exception.h
)

set(GENERATED_ICEGRIDDB_SOURCES
    ${GENERATED_ICEGRIDDB_SOURCES_DIR}/DBTypes.cpp
    ${GENERATED_ICEGRIDDB_SOURCES_DIR}/Descriptor.cpp
    ${GENERATED_ICEGRIDDB_SOURCES_DIR}/Exception.cpp
)

set_source_files_properties(
    ${GENERATED_ICEGRIDDB_HEADERS}
    ${GENERATED_ICEGRIDDB_SOURCES}
    PROPERTIES
        GENERATED TRUE
)

add_executable(icegriddb)

target_sources(icegriddb
    PRIVATE
        IceGridDB.cpp
        ${GENERATED_ICEGRIDDB_HEADERS}
        ${GENERATED_ICEGRIDDB_SOURCES}
        ${ICEGRIDDB_SLICES}
)

target_include_directories(icegriddb
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
        ${LMDB_INCLUDE_DIR} 
)

target_compile_definitions(icegriddb
    PRIVATE
        ${ICE_COMPILE_DEFS}
        "ICE_BUILDING_ICE_GRID"
)

target_link_libraries(icegriddb
    PRIVATE
        lmdb
        ice
        icedb
        icegrid
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceGridDB.rc
    )

    source_group(
        TREE ${GENERATED_ICEGRIDDB_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICEGRIDDB_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICEGRIDDB_SOURCES_DIR}
        PREFIX "Source Files/Generated"
        FILES
            ${GENERATED_ICEGRIDDB_SOURCES}
    )

    source_group(
        TREE ${SLICE_DIR}/IceGrid
        PREFIX "Slice Files"
        FILES
            ${ICEGRIDDB_SLICES}
    )

    target_sources(icegriddb
        PRIVATE
            IceGridDB.rc
    )

    target_compile_options(icegriddb
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}   
    )

    target_compile_definitions(icegriddb
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )

    target_link_options(icegriddb
        PRIVATE
            ${ICE_WIN32_LINK_OPTIONS}
    )

    target_link_libraries(icegriddb
        PRIVATE
            advapi32.lib
            ws2_32.lib
            Iphlpapi.lib
            rpcrt4.lib
            DbgHelp.lib
            Shlwapi.lib
    )
endif()

foreach(slice ${ICEGRIDDB_SLICES})
    #function(CompileSlices slice2_bin slice_path ice_file slice_target include_dir output_dir)
    CompileSlices(slice2cpp
        ${SLICE_DIR}
        ${slice}
        icegriddb
        IceGrid
        ${GENERATED_ICEGRIDDB_SOURCES_DIR}
    )
endforeach()

# # ${CMAKE_CURRENT_SOURCE_DIR}/DBTypes.ice
# CompileSlices(slice2cpp
#     ${SLICE_DIR}
#     ${CMAKE_CURRENT_SOURCE_DIR}/DBTypes.ice
#     icegriddb
#     IceGrid
#     ${GENERATED_ICEGRIDDB_SOURCES_DIR}
# )

install(TARGETS icegriddb DESTINATION bin)
