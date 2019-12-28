add_library(icexml)

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

target_link_libraries(icexml
    PRIVATE
        ice
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceXML.rc
    )

    target_sources(icexml
        PRIVATE
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

set_target_properties(icexml 
    PROPERTIES
        OUTPUT_NAME icexml${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
)

install(TARGETS icexml DESTINATION lib)
