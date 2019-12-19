add_library(icexml)

add_dependencies(icexml ice)

target_sources(icexml
    PRIVATE
        Parser.cpp
        Parser.h
)

target_include_directories(icexml
    PRIVATE
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
        ${EXPAT_INCLUDE_DIR}
)

target_compile_definitions(icexml
    PRIVATE
        ${ICE_COMPILE_DEFS}
        "ICE_XML_API_EXPORTS"
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceXML.rc
    )

    target_compile_options(icexml
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}
    )

    target_compile_definitions(icexml
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )
endif()

install(TARGETS icexml DESTINATION lib)
