if(NOT ${GENERATED_HEADERS_DIR}/IceGrid)
    file(MAKE_DIRECTORY ${GENERATED_HEADERS_DIR}/IceGrid)
endif()

# set(GENERATED_ICEGRID_SOURCES_DIR
#     ${PROJECT_BINARY_DIR}/generated/IceGrid
# )

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
    ${GENERATED_HEADERS_DIR}/IceGrid/Admin.h
    ${GENERATED_HEADERS_DIR}/IceGrid/Descriptor.h
    ${GENERATED_HEADERS_DIR}/IceGrid/Exception.h
    ${GENERATED_HEADERS_DIR}/IceGrid/FileParser.h
    ${GENERATED_HEADERS_DIR}/IceGrid/PluginFacade.h
    ${GENERATED_HEADERS_DIR}/IceGrid/Registry.h
    ${GENERATED_HEADERS_DIR}/IceGrid/Session.h
    ${GENERATED_HEADERS_DIR}/IceGrid/UserAccountMapper.h
)

set(GENERATED_ICEGRID_SOURCES
    ${CMAKE_CURRENT_BINARY_DIR}/Admin.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/Descriptor.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/Exception.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/FileParser.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/PluginFacade.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/Registry.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/Session.cpp
    ${CMAKE_CURRENT_BINARY_DIR}/UserAccountMapper.cpp
)

# set_source_files_properties(
#     ${GENERATED_ICEGRID_HEADERS}
#     ${GENERATED_ICEGRID_SOURCES}
#     PROPERTIES
#         GENERATED TRUE
# )

add_library(icegrid)

target_sources(icegrid
    PRIVATE
        PluginFacadeI.cpp
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
        ${GENERATED_HEADERS_DIR}
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src  
)

target_compile_definitions(icegrid
    PRIVATE
        ${ICE_COMPILE_DEFS}
        "ICEGRID_API_EXPORTS"
)

target_link_libraries(icegrid
    PRIVATE
        glacier2
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceGrid.rc
    )

    source_group(
        TREE ${GENERATED_HEADERS_DIR}/IceGrid
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICEGRID_HEADERS}
    )

    source_group(
        TREE ${CMAKE_CURRENT_BINARY_DIR}
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
            IceGrid.rc
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

list(APPEND ICEGRID_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICEGRID_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceGrid")

foreach(slice ${ICEGRID_SLICES})
    get_filename_component(slice_name ${slice} NAME_WE)
    #function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_file)
    CompileSlice(slice2cpp
        "${ICEGRID_SLICE_PARAMS}"
        "${ICEGRID_SLICE_DIRS}"
        ${slice}
        ${GENERATED_HEADERS_DIR}/IceGrid/${slice_name}.h
        ${CMAKE_CURRENT_BINARY_DIR}/${slice_name}.cpp
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
