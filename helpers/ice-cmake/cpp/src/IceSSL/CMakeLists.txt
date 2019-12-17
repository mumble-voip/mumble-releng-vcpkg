if(NOT ${PROJECT_BINARY_DIR}/generated/IceSSL)
    file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/IceSSL)
endif()

set(GENERATED_ICESSL_SOURCES_DIR
    ${PROJECT_BINARY_DIR}/generated/IceSSL
)

set(ICESSL_SLICES
    ${SLICE_DIR}/IceSSL/ConnectionInfo.ice
    ${SLICE_DIR}/IceSSL/ConnectionInfoF.ice
    ${SLICE_DIR}/IceSSL/EndpointInfo.ice
)

set(GENERATED_ICESSL_HEADERS
    ${GENERATED_ICESSL_SOURCES_DIR}/IceSSL.h
)

set(GENERATED_ICESSL_SOURCES
    ${GENERATED_ICESSL_SOURCES_DIR}/IceSSL.cpp
)

set_source_files_properties(
    ${GENERATED_ICESSL_HEADERS}
    ${GENERATED_ICESSL_SOURCES}
    PROPERTIES
        GENERATED TRUE
)

add_library(icessl)

target_sources(icessl
    PRIVATE
        AcceptorI.cpp
        CertificateI.cpp
        ConnectorI.cpp
        EndpointI.cpp
        Instance.cpp
        OpenSSLCertificateI.cpp
        OpenSSLEngine.cpp
        OpenSSLPluginI.cpp
        OpenSSLTransceiverI.cpp
        OpenSSLUtil.cpp
        PluginI.cpp
        RFC2253.cpp
        SChannelCertificateI.cpp
        SChannelEngine.cpp
        SChannelPluginI.cpp
        SChannelTransceiverI.cpp
        SecureTransportCertificateI.cpp
        SecureTransportEngine.cpp
        SecureTransportPluginI.cpp
        SecureTransportTransceiverI.cpp
        SecureTransportUtil.cpp
        SSLEngine.cpp
        TrustManager.cpp
        Util.cpp
        UWPCertificateI.cpp
        UWPEngine.cpp
        UWPPluginI.cpp
        UWPTransceiverI.cpp
        AcceptorI.h
        CertificateI.h
        ConnectorI.h
        EndpointI.h
        Instance.h
        InstanceF.h
        OpenSSLEngine.h
        OpenSSLEngineF.h
        OpenSSLTransceiverI.h
        OpenSSLUtil.h
        PluginI.h
        RFC2253.h
        SChannelEngine.h
        SChannelEngineF.h
        SChannelTransceiverI.h
        SecureTransportEngine.h
        SecureTransportEngineF.h
        SecureTransportTransceiverI.h
        SecureTransportUtil.h
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
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src    
)

if(CMAKE_CXX_STANDARD EQUAL 11)
    set(ICESSL_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    set(ICESSL_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS}")
endif()

target_compile_definitions(icessl
    PRIVATE
        ${ICESSL_COMPILE_DEFS}
        "ICESSL_API_EXPORTS"
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            IceSSL.rc
    )

    source_group(
        TREE ${GENERATED_ICESSL_SOURCES_DIR}
        PREFIX "Header Files/Generated"
        FILES
            ${GENERATED_ICESSL_HEADERS}
    )

    source_group(
        TREE ${GENERATED_ICESSL_SOURCES_DIR}
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
            ${ICE_COMPILE_OPTIONS}   
    )
endif()

foreach(slice ${ICESSL_SLICES})
    #function(CompileSlices slice2_bin slice_path ice_file slice_target include_dir output_dir)
    CompileSlices(slice2cpp
        ${SLICE_DIR}
        ${slice}
        icessl
        IceSSL
        ${GENERATED_ICESSL_SOURCES_DIR}
    )
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
    set_target_properties(icessl 
        PROPERTIES
            OUTPUT_NAME icessl++11
    )
endif()

install(TARGETS icessl DESTINATION lib)
