if(NOT ${PROJECT_BINARY_DIR}/generated/IceStorm)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceStorm)
endif()

set(GENERATED_ICESTORMSERVICE_SOURCES_DIR
    ${PROJECT_BINARY_DIR}/generated/IceStorm
)

set(ICESTORMSERVICE_SLICES
    ${CMAKE_CURRENT_SOURCE_DIR}/Election.ice
    ${CMAKE_CURRENT_SOURCE_DIR}/IceStormInternal.ice
    ${CMAKE_CURRENT_SOURCE_DIR}/Instrumentation.ice
    ${CMAKE_CURRENT_SOURCE_DIR}/LinkRecord.ice
    ${CMAKE_CURRENT_SOURCE_DIR}/LLURecord.ice
    ${CMAKE_CURRENT_SOURCE_DIR}/SubscriberRecord.ice
)

set(GENERATED_ICESTORMSERVICE_HEADERS
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/Election.h
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/IceStormInternal.h
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/Instrumentation.h
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/LinkRecord.h
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/LLURecord.h
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/SubscriberRecord.h
)

set(GENERATED_ICESTORMSERVICE_SOURCES
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/Election.cpp
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/IceStormInternal.cpp
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/Instrumentation.cpp
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/LinkRecord.cpp
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/LLURecord.cpp
    ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}/SubscriberRecord.cpp
)

set_source_files_properties(
    ${GENERATED_ICESTORMSERVICE_HEADERS}
    ${GENERATED_ICESTORMSERVICE_SOURCES}
    PROPERTIES
        GENERATED TRUE
)

add_library(icestormservice)

target_sources(icestormservice
    PRIVATE
        Instance.cpp
        Instance.h
        InstrumentationI.cpp
        InstrumentationI.h
        NodeI.cpp
        NodeI.h
        Observers.cpp
        Observers.h
        Replica.h
        Service.cpp
        Service.h
        Subscriber.cpp
        Subscriber.h
        TopicI.cpp
        TopicI.h
        TopicManagerI.cpp
        TopicManagerI.h
        TraceLevels.cpp
        TraceLevels.h
        TransientTopicI.cpp
        TransientTopicI.h
        TransientTopicManagerI.cpp
        TransientTopicManagerI.h
        Util.cpp
        Util.h
        ${GENERATED_ICESTORMSERVICE_HEADERS}
        ${GENERATED_ICESTORMSERVICE_SOURCES}
        ${ICESTORMSERVICE_SLICES}
)

target_include_directories(icestormservice
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
        ${LMDB_INCLUDE_DIR}
)

target_compile_definitions(icestormservice
    PRIVATE
        ${ICE_COMPILE_DEFS}
)

target_link_libraries(icestormservice
    PRIVATE
        glacier2
        iceboxlib
        icedb
        icegrid
        icestorm
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceStormService.rc
    )

    source_group(
        TREE ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICESTORMSERVICE_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICESTORMSERVICE_SOURCES_DIR}
        PREFIX "Source Files/Generated"
        FILES
            ${GENERATED_ICESTORMSERVICE_SOURCES}
    )

    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Slice Files"
        FILES
            ${ICESTORMSERVICE_SLICES}
    )

    target_sources(icestorm
        PRIVATE
            IceStormService.rc
    )

    target_compile_options(icestormservice
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}   
    )

    target_compile_definitions(icestormservice
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )
endif()

list(APPEND ICESTORMSERVICE_SLICE_DIRS "I${SLICE_DIR}" "-I${PROJECT_SOURCE_DIR}/cpp/src")

foreach(slice ${ICESTORMSERVICE_SLICES})
    #function(CompileSlice slice2_bin slice_include_paths ice_file slice_target include_dir output_dir)
    CompileSlice(slice2cpp
        ${ICESTORMSERVICE_SLICE_DIRS}
        ${slice}
        icestormservice
        IceStorm
        ${GENERATED_ICESSL_SOURCES_DIR}
    )
endforeach()

set_target_properties(icestormservice
    PROPERTIES
        OUTPUT_NAME icestormservice${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
)
