if(NOT ${PROJECT_BINARY_DIR}/generated/IceBox)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceBox)
endif()

set(GENERATED_ICEBOX_SOURCES_DIR 
    ${PROJECT_BINARY_DIR}/generated/IceBox
)

set(ICEBOX_SLICES
    ${SLICE_DIR}/IceBox/IceBox.ice
)

set(GENERATED_ICEBOX_HEADERS
    ${GENERATED_ICEBOX_SOURCES_DIR}/IceBox.h
)

set(GENERATED_ICEBOX_SOURCES
    ${GENERATED_ICEBOX_SOURCES_DIR}/IceBox.cpp
)

set_source_files_properties(
    ${GENERATED_ICEBOX_HEADERS}
    ${GENERATED_ICEBOX_SOURCES} 
    PROPERTIES 
        GENERATED TRUE
)

if(CMAKE_CXX_STANDARD EQUAL 11)
    set(ICEBOX_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set(ICEBOX_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS}")
endif()

add_library(iceboxlib)

add_dependencies(iceboxlib ice)

target_sources(iceboxlib
    PRIVATE
        Exception.cpp
        ${GENERATED_ICEBOX_HEADERS}
        ${GENERATED_ICEBOX_SOURCES}
)

target_include_directories(iceboxlib
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(iceboxlib 
    PRIVATE 
        ${ICEBOX_COMPILE_DEFS}
        "ICEBOX_API_EXPORTS"
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceBox.rc
    )

    source_group(
        TREE ${GENERATED_ICEBOX_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICEBOX_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICEBOX_SOURCES_DIR}
        PREFIX "Source Files/Generated"
        FILES
            ${GENERATED_ICEBOX_SOURCES}
    )

    source_group(
        TREE ${SLICE_DIR}/IceBox
        PREFIX "Slice Files"
        FILES
            ${ICEBOX_SLICES}
    )

    target_sources(iceboxlib
        PRIVATE
            IceBox.rc
    )

    target_compile_options(iceboxlib 
        PRIVATE
            ${ICE_COMPILE_OPTIONS}   
    )
	
endif()

foreach(slice ${ICEBOX_SLICES})
    #function(CompileSlices slice2_bin slice_path ice_file slice_target optional_args output_dir)
    CompileSlices(slice2cpp
        ${SLICE_DIR}
        ${slice}
        iceboxlib
        IceBox
        ${GENERATED_ICEBOX_SOURCES_DIR}
    )
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
    set_target_properties(iceboxlib 
        PROPERTIES
            OUTPUT_NAME icebox${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
    )
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set_target_properties(iceboxlib 
        PROPERTIES
            OUTPUT_NAME icebox${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
    )
endif()

install(TARGETS iceboxlib DESTINATION lib)

add_executable(icebox)

target_sources(icebox 
    PRIVATE
        Service.cpp
        ServiceManagerI.cpp
        ServiceManagerI.h
)

target_include_directories(icebox
    PRIVATE
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(icebox
    PRIVATE
        ${ICEBOX_COMPILE_DEFS}
)

target_link_libraries(icebox
    PRIVATE
        iceutil
        ice
        iceboxlib
        ${BZIP2_LIBRARIES}
)

if(WIN32)

    target_sources(icebox
        PRIVATE
            IceBoxExe.rc
	)

    target_compile_options(icebox
        PRIVATE
            ${ICE_COMPILE_OPTIONS}
	)

    target_link_options(icebox
        PRIVATE
            ${ICE_APP_ADDITIONAL_DEPS}
	)

    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceBoxExe.rc
    )
    target_link_libraries(icebox
        PRIVATE
            advapi32.lib
            ws2_32.lib
            Iphlpapi.lib
            rpcrt4.lib
            DbgHelp.lib
            Shlwapi.lib
    )

endif()

if(CMAKE_CXX_STANDARD EQUAL 98)

    add_executable(iceboxadmin)

    target_sources(iceboxadmin
        PRIVATE
            Admin.cpp
    )

    target_include_directories(iceboxadmin
        PRIVATE
            ${PROJECT_BINARY_DIR}/generated
            ${PROJECT_SOURCE_DIR}/cpp/include
            ${PROJECT_SOURCE_DIR}/cpp/src
    )

    target_link_libraries(iceboxadmin
        PRIVATE
            iceboxlib
            ice
    )

    target_compile_definitions(iceboxadmin
        PRIVATE
            ${ICE_CPP98_COMPILE_DEFS}
    )

    if(WIN32)
        target_sources(iceboxadmin
            PRIVATE
                IceBoxAdmin.rc
        )

        target_compile_options(iceboxadmin
            PRIVATE
                ${ICE_COMPILE_OPTIONS}
        )

        target_link_options(iceboxadmin
            PRIVATE
                ${ICE_APP_ADDITIONAL_DEPS}
        )

        target_link_libraries(iceboxadmin
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
                IceBoxAdmin.rc
        )

    endif()
    
    install(TARGETS iceboxadmin DESTINATION bin)

endif()

install(TARGETS icebox DESTINATION bin)
