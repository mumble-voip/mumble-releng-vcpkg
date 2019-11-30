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

target_sources(iceboxlib
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/Exception.cpp
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

add_dependencies(iceboxlib ice)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            ${CMAKE_CURRENT_SOURCE_DIR}/IceBox.rc
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
            ${CMAKE_CURRENT_SOURCE_DIR}/IceBox.rc
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
        ${CMAKE_CURRENT_SOURCE_DIR}/Service.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ServiceManagerI.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ServiceManagerI.h
)

target_include_directories(icebox
    PRIVATE
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
)

if(WIN32)
    target_sources(icebox
        PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/IceBoxExe.rc
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
            ${CMAKE_CURRENT_SOURCE_DIR}/IceBoxExe.rc
    )	

endif()

target_compile_definitions(icebox
    PRIVATE
        ${ICEBOX_COMPILE_DEFS}
)

target_link_libraries(icebox	
    PRIVATE
        iceutil
        ice
        iceboxlib
)

install(TARGETS icebox DESTINATION bin)
