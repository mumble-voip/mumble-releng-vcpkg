if(NOT ${GENERATED_SLICES_DIR}/IceSSL)
    file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceSSL)
endif()

set(ICESSL_SLICES
    ${SLICE_DIR}/IceSSL/ConnectionInfo.ice
    ${SLICE_DIR}/IceSSL/ConnectionInfoF.ice
    ${SLICE_DIR}/IceSSL/EndpointInfo.ice
)

set(GENERATED_ICESSL_HEADERS
    ${GENERATED_SLICES_DIR}/IceSSL/ConnectionInfo.h
    ${GENERATED_SLICES_DIR}/IceSSL/ConnectionInfoF.h
    ${GENERATED_SLICES_DIR}/IceSSL/EndpointInfo.h
)

set(GENERATED_ICESSL_SOURCES
    ${GENERATED_SLICES_DIR}/IceSSL/ConnectionInfo.cpp
    ${GENERATED_SLICES_DIR}/IceSSL/ConnectionInfoF.cpp
    ${GENERATED_SLICES_DIR}/IceSSL/EndpointInfo.cpp
)

add_library(icessl)

target_sources(icessl
    PRIVATE
        AcceptorI.cpp
        CertificateI.cpp
        ConnectorI.cpp
        EndpointI.cpp
        Instance.cpp
        PluginI.cpp
        RFC2253.cpp
        SChannelCertificateI.cpp
        SChannelEngine.cpp
        SChannelPluginI.cpp
        SChannelTransceiverI.cpp
        # SecureTransportCertificateI.cpp
        # SecureTransportEngine.cpp
        # SecureTransportPluginI.cpp
        # SecureTransportTransceiverI.cpp
        # SecureTransportUtil.cpp
        SSLEngine.cpp
        TrustManager.cpp
        Util.cpp
        AcceptorI.h
        CertificateI.h
        ConnectorI.h
        EndpointI.h
        Instance.h
        InstanceF.h
        PluginI.h
        RFC2253.h
        SChannelEngine.h
        SChannelEngineF.h
        SChannelTransceiverI.h
        # SecureTransportEngine.h
        # SecureTransportEngineF.h
        # SecureTransportTransceiverI.h
        # SecureTransportUtil.h
        SSLEngine.h
        SSLEngineF.h
        TrustManager.h
        TrustManagerF.h
        Util.h
        ${GENERATED_ICESSL_HEADERS}
        ${GENERATED_ICESSL_SOURCES}
        ${ICESSL_SLICES}
)

target_include_directories(icessl
    PRIVATE 
        ${GENERATED_SLICES_DIR}
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src 
)

target_compile_definitions(icessl
    PRIVATE
        ${ICE_COMPILE_DEFS}
        "ICESSL_API_EXPORTS"
)

target_link_libraries(icessl
    PRIVATE
        ice
)

if(${CMAKE_SYSTEM_NAME} EQUAL "WindowsStore")
    target_sources(icessl
        PRIVATE
            UWPCertificateI.cpp
            UWPEngine.cpp
            UWPPluginI.cpp
            UWPTransceiverI.cpp
            UWPEngine.h
            UWPEngineF.h
            UWPTransceiverI.h
    )
endif()

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceSSL.rc
    )

    source_group(
        TREE ${GENERATED_SLICES_DIR}/IceSSL
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICESSL_HEADERS}
    )

    source_group(
        TREE ${GENERATED_SLICES_DIR}/IceSSL
        PREFIX "Source Files/Generated"
        FILES
            ${GENERATED_ICESSL_SOURCES}
    )

    source_group(
        TREE ${SLICE_DIR}/IceSSL
        PREFIX "Slice Files"
        FILES
            ${ICESSL_SLICES}
    )

    target_sources(icessl
        PRIVATE
            IceSSL.rc
    )

    target_compile_options(icessl 
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}   
    )

    target_compile_definitions(icessl
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )
endif()

list(APPEND ICESSL_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICESSL_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceSSL")

foreach(slice ${ICESSL_SLICES})
    get_filename_component(slice_name ${slice} NAME_WE)
    #function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_file)
    CompileSlice(slice2cpp
        "${ICESSL_SLICE_PARAMS}"
        "${ICESSL_SLICE_DIRS}"
        ${slice}
        ${GENERATED_SLICES_DIR}/IceSSL
        ${GENERATED_SLICES_DIR}/IceSSL/${slice_name}.cpp
        ${GENERATED_SLICES_DIR}/IceSSL/${slice_name}.h
    )
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
    set_target_properties(icessl
        PROPERTIES
            OUTPUT_NAME icessl${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
    )
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set_target_properties(icessl 
        PROPERTIES
            OUTPUT_NAME icessl${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
    )
endif()

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceSSL DESTINATION generated)
install(TARGETS icessl DESTINATION lib)

if(CMAKE_CXX_STANDARD EQUAL 11)
    add_library(icesslopenssl STATIC)

    add_dependencies(icesslopenssl ice)

    target_sources(icesslopenssl
        PRIVATE
            OpenSSLCertificateI.cpp
            OpenSSLEngine.cpp
            OpenSSLPluginI.cpp
            OpenSSLTransceiverI.cpp
            OpenSSLUtil.cpp
            OpenSSLEngine.h
            OpenSSLEngineF.h
            OpenSSLTransceiverI.h
            OpenSSLUtil.h
    )

    target_include_directories(icesslopenssl
        PRIVATE
            ${PROJECT_BINARY_DIR}/generated
            ${PROJECT_SOURCE_DIR}/cpp/include
            ${PROJECT_SOURCE_DIR}/cpp/src 
            ${OPENSSL_INCLUDE_DIR}
    )

    target_compile_definitions(icesslopenssl
        PRIVATE
            ${ICE_CPP11_COMPILE_DEFS}
            "ICESSL_OPENSSL_API_EXPORTS"
    )

    if(WIN32)
        source_group(
            TREE ${CMAKE_CURRENT_SOURCE_DIR}
            PREFIX "Resource Files"
            FILES
                IceSSLOpenSSL.rc
        )

        target_sources(icesslopenssl
            PRIVATE
                IceSSLOpenSSL.rc
        )

        target_compile_options(icesslopenssl 
            PRIVATE
                ${ICE_WIN32_COMPILE_OPTIONS}   
        )

        target_compile_definitions(icesslopenssl
            PRIVATE
                ${ICE_WIN32_COMPILE_DEFS}
        )
    endif()

    if(CMAKE_CXX_STANDARD EQUAL 11)
        set_target_properties(icesslopenssl 
            PROPERTIES
                OUTPUT_NAME icesslopenssl++11
        )
    endif()

    install(TARGETS icesslopenssl DESTINATION lib)
endif()
