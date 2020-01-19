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

set(ICESSL_SOURCES
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
	SSLEngine.h
	SSLEngineF.h
	TrustManager.h
	TrustManagerF.h
	Util.h
	${ICESSL_SLICES}
)

if(NOT WINDOWS_STORE)
	list(APPEND ICESSL_SLICE_DIRS "-I${SLICE_DIR}")
	list(APPEND ICESSL_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceSSL")

	foreach(slice ${ICESSL_SLICES})
		get_filename_component(slice_name ${slice} NAME_WE)
		set(output_files 
			${GENERATED_SLICES_DIR}/IceSSL/${slice_name}.cpp
			${GENERATED_SLICES_DIR}/IceSSL/${slice_name}.h
		)
		#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
		CompileSlice(slice2cpp
			"${ICESSL_SLICE_PARAMS}"
			"${ICESSL_SLICE_DIRS}"
			${slice}
			${GENERATED_SLICES_DIR}/IceSSL
			"${output_files}"
		)
	endforeach()

	add_library(icessl)

	target_sources(icessl
		PRIVATE
			${ICESSL_SOURCES}
			${GENERATED_ICESSL_HEADERS}
			${GENERATED_ICESSL_SOURCES}
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

	if(MSVC)
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
				${ICE_MSVC_COMPILE_OPTIONS}   
		)

		target_compile_definitions(icessl
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
		)

		target_link_libraries(icessl
			PRIVATE
				advapi32.lib
				secur32.lib
				crypt32.lib
				ws2_32.lib
		)
	endif()

	set_target_properties(icessl 
		PROPERTIES
			OUTPUT_NAME IceSSL${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
	)

	install(DIRECTORY ${GENERATED_SLICES_DIR}/IceSSL 
		DESTINATION include
		FILES_MATCHING PATTERN "*.h"
	)
	install(TARGETS icessl DESTINATION lib)

	add_library(icessl++11)

	target_sources(icessl++11
		PRIVATE
			${ICESSL_SOURCES}
			${GENERATED_ICESSL_HEADERS}
			${GENERATED_ICESSL_SOURCES}
	)

	target_include_directories(icessl++11
		PRIVATE 
			${GENERATED_SLICES_DIR}
			${PROJECT_SOURCE_DIR}/cpp/include
			${PROJECT_SOURCE_DIR}/cpp/src 
	)

	target_compile_definitions(icessl++11
		PRIVATE
			${ICE_CPP11_COMPILE_DEFS}
			"ICESSL_API_EXPORTS"
	)

	target_link_libraries(icessl++11
		PRIVATE
			ice++11
	)

	if(MSVC)
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

		target_sources(icessl++11
			PRIVATE
				IceSSL.rc
		)

		target_compile_options(icessl++11 
			PRIVATE
				${ICE_MSVC_COMPILE_OPTIONS}   
		)

		target_compile_definitions(icessl++11
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
		)

		target_link_libraries(icessl++11
			PRIVATE
				advapi32.lib
				secur32.lib
				crypt32.lib
				ws2_32.lib
		)
	endif()

	set_target_properties(icessl++11 
		PROPERTIES
			OUTPUT_NAME IceSSL${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
	)

	install(DIRECTORY ${GENERATED_SLICES_DIR}/IceSSL 
		DESTINATION include
		FILES_MATCHING PATTERN "*.h"
	)
	install(TARGETS icessl++11 DESTINATION lib)

	add_library(icesslopenssl)

	target_sources(icesslopenssl
		PRIVATE
			OpenSSLCertificateI.cpp
			OpenSSLEngine.cpp
			OpenSSLEngine.h
			OpenSSLEngineF.h
			OpenSSLPluginI.cpp
			OpenSSLTransceiverI.cpp
			OpenSSLTransceiverI.h
			OpenSSLUtil.cpp
			OpenSSLUtil.h
	)

	target_include_directories(icesslopenssl
		PRIVATE
			${GENERATED_SLICES_DIR}
			${PROJECT_SOURCE_DIR}/cpp/include
			${PROJECT_SOURCE_DIR}/cpp/src 
			${OPENSSL_INCLUDE_DIR}
	)

	target_compile_definitions(icesslopenssl
		PRIVATE
			${ICE_COMPILE_DEFS}
			"ICESSL_OPENSSL_API_EXPORTS"
	)

	target_link_libraries(icesslopenssl
		PRIVATE 
			icessl
			OpenSSL::SSL 
			OpenSSL::Crypto
	)

	if(MSVC)
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
				${ICE_MSVC_COMPILE_OPTIONS}   
		)

		target_compile_definitions(icesslopenssl
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
		)
	endif()

	set_target_properties(icesslopenssl 
		PROPERTIES
			OUTPUT_NAME IceSSLOpenSSL
	)

	install(TARGETS icesslopenssl DESTINATION lib)

	add_library(icesslopenssl++11)

	target_sources(icesslopenssl++11
		PRIVATE
			OpenSSLCertificateI.cpp
			OpenSSLEngine.cpp
			OpenSSLEngine.h
			OpenSSLEngineF.h
			OpenSSLPluginI.cpp
			OpenSSLTransceiverI.cpp
			OpenSSLTransceiverI.h
			OpenSSLUtil.cpp
			OpenSSLUtil.h
	)

	target_include_directories(icesslopenssl++11
		PRIVATE
			${GENERATED_SLICES_DIR}
			${PROJECT_SOURCE_DIR}/cpp/include
			${PROJECT_SOURCE_DIR}/cpp/src 
			${OPENSSL_INCLUDE_DIR}
	)

	target_compile_definitions(icesslopenssl++11
		PRIVATE
			${ICE_CPP11_COMPILE_DEFS}
			"ICESSL_OPENSSL_API_EXPORTS"
	)

	target_link_libraries(icesslopenssl++11 
		PRIVATE 
			icessl++11
			OpenSSL::SSL 
			OpenSSL::Crypto
	)

	if(MSVC)
		source_group(
			TREE ${CMAKE_CURRENT_SOURCE_DIR}
			PREFIX "Resource Files"
			FILES
				IceSSLOpenSSL.rc
		)

		target_sources(icesslopenssl++11
			PRIVATE
				IceSSLOpenSSL.rc
		)

		target_compile_options(icesslopenssl++11 
			PRIVATE
				${ICE_MSVC_COMPILE_OPTIONS}   
		)

		target_compile_definitions(icesslopenssl++11
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
		)
	endif()

	set_target_properties(icesslopenssl++11 
		PROPERTIES
			OUTPUT_NAME IceSSLOpenSSL++11
	)

	install(TARGETS icesslopenssl++11 DESTINATION lib)
endif()
