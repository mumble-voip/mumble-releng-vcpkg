if(NOT ${GENERATED_SLICES_DIR}/Ice)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/Ice)
endif()

set(GENERATED_ICE_HEADERS
	${GENERATED_SLICES_DIR}/Ice/BuiltinSequences.h
	${GENERATED_SLICES_DIR}/Ice/Communicator.h
	${GENERATED_SLICES_DIR}/Ice/CommunicatorF.h
	${GENERATED_SLICES_DIR}/Ice/Connection.h
	${GENERATED_SLICES_DIR}/Ice/ConnectionF.h
	${GENERATED_SLICES_DIR}/Ice/Current.h
	${GENERATED_SLICES_DIR}/Ice/Endpoint.h
	${GENERATED_SLICES_DIR}/Ice/EndpointF.h
	${GENERATED_SLICES_DIR}/Ice/EndpointTypes.h
	${GENERATED_SLICES_DIR}/Ice/FacetMap.h
	${GENERATED_SLICES_DIR}/Ice/Identity.h
	${GENERATED_SLICES_DIR}/Ice/ImplicitContext.h
	${GENERATED_SLICES_DIR}/Ice/ImplicitContextF.h
	${GENERATED_SLICES_DIR}/Ice/Instrumentation.h
	${GENERATED_SLICES_DIR}/Ice/InstrumentationF.h
	${GENERATED_SLICES_DIR}/Ice/LocalException.h
	${GENERATED_SLICES_DIR}/Ice/Locator.h
	${GENERATED_SLICES_DIR}/Ice/LocatorF.h
	${GENERATED_SLICES_DIR}/Ice/Logger.h
	${GENERATED_SLICES_DIR}/Ice/LoggerF.h
	${GENERATED_SLICES_DIR}/Ice/Metrics.h
	${GENERATED_SLICES_DIR}/Ice/ObjectAdapter.h
	${GENERATED_SLICES_DIR}/Ice/ObjectAdapterF.h
	${GENERATED_SLICES_DIR}/Ice/ObjectFactory.h
	${GENERATED_SLICES_DIR}/Ice/Plugin.h
	${GENERATED_SLICES_DIR}/Ice/PluginF.h
	${GENERATED_SLICES_DIR}/Ice/Process.h
	${GENERATED_SLICES_DIR}/Ice/ProcessF.h
	${GENERATED_SLICES_DIR}/Ice/Properties.h
	${GENERATED_SLICES_DIR}/Ice/PropertiesAdmin.h
	${GENERATED_SLICES_DIR}/Ice/PropertiesF.h
	${GENERATED_SLICES_DIR}/Ice/RemoteLogger.h
	${GENERATED_SLICES_DIR}/Ice/Router.h
	${GENERATED_SLICES_DIR}/Ice/RouterF.h
	${GENERATED_SLICES_DIR}/Ice/ServantLocator.h
	${GENERATED_SLICES_DIR}/Ice/ServantLocatorF.h
	${GENERATED_SLICES_DIR}/Ice/SliceChecksumDict.h
	${GENERATED_SLICES_DIR}/Ice/ValueFactory.h
	${GENERATED_SLICES_DIR}/Ice/Version.h
)

set(GENERATED_ICE_SOURCES
	${GENERATED_SLICES_DIR}/Ice/BuiltinSequences.cpp
	${GENERATED_SLICES_DIR}/Ice/Communicator.cpp
	${GENERATED_SLICES_DIR}/Ice/CommunicatorF.cpp
	${GENERATED_SLICES_DIR}/Ice/Connection.cpp
	${GENERATED_SLICES_DIR}/Ice/ConnectionF.cpp
	${GENERATED_SLICES_DIR}/Ice/Current.cpp
	${GENERATED_SLICES_DIR}/Ice/Endpoint.cpp
	${GENERATED_SLICES_DIR}/Ice/EndpointF.cpp
	${GENERATED_SLICES_DIR}/Ice/EndpointTypes.cpp
	${GENERATED_SLICES_DIR}/Ice/FacetMap.cpp
	${GENERATED_SLICES_DIR}/Ice/Identity.cpp
	${GENERATED_SLICES_DIR}/Ice/ImplicitContext.cpp
	${GENERATED_SLICES_DIR}/Ice/ImplicitContextF.cpp
	${GENERATED_SLICES_DIR}/Ice/Instrumentation.cpp
	${GENERATED_SLICES_DIR}/Ice/InstrumentationF.cpp
	${GENERATED_SLICES_DIR}/Ice/LocalException.cpp
	${GENERATED_SLICES_DIR}/Ice/Locator.cpp
	${GENERATED_SLICES_DIR}/Ice/LocatorF.cpp
	${GENERATED_SLICES_DIR}/Ice/Logger.cpp
	${GENERATED_SLICES_DIR}/Ice/LoggerF.cpp
	${GENERATED_SLICES_DIR}/Ice/Metrics.cpp
	${GENERATED_SLICES_DIR}/Ice/ObjectAdapter.cpp
	${GENERATED_SLICES_DIR}/Ice/ObjectAdapterF.cpp
	${GENERATED_SLICES_DIR}/Ice/ObjectFactory.cpp
	${GENERATED_SLICES_DIR}/Ice/Plugin.cpp
	${GENERATED_SLICES_DIR}/Ice/PluginF.cpp
	${GENERATED_SLICES_DIR}/Ice/Process.cpp
	${GENERATED_SLICES_DIR}/Ice/ProcessF.cpp
	${GENERATED_SLICES_DIR}/Ice/Properties.cpp
	${GENERATED_SLICES_DIR}/Ice/PropertiesAdmin.cpp
	${GENERATED_SLICES_DIR}/Ice/PropertiesF.cpp
	${GENERATED_SLICES_DIR}/Ice/RemoteLogger.cpp
	${GENERATED_SLICES_DIR}/Ice/Router.cpp
	${GENERATED_SLICES_DIR}/Ice/RouterF.cpp
	${GENERATED_SLICES_DIR}/Ice/ServantLocator.cpp
	${GENERATED_SLICES_DIR}/Ice/ServantLocatorF.cpp
	${GENERATED_SLICES_DIR}/Ice/SliceChecksumDict.cpp
	${GENERATED_SLICES_DIR}/Ice/ValueFactory.cpp
	${GENERATED_SLICES_DIR}/Ice/Version.cpp
)

if(MSVC AND NOT BUILD_ICE_UWP)
	set(GENERATED_ICE_RESOURCES
		${GENERATED_SLICES_DIR}/Ice/EventLoggerMsg.h
		${GENERATED_SLICES_DIR}/Ice/EventLoggerMsg.rc
	)
endif()

if(BUILD_ICE_UWP)
	set(ICE_SOURCES
		Acceptor.cpp
		ACM.cpp
		AsyncResult.cpp
		ArgVector.cpp
		Base64.cpp
		BatchRequestQueue.cpp
		Buffer.cpp
		CollocatedRequestHandler.cpp
		CommunicatorI.cpp
		Cond.cpp
		ConnectionFactory.cpp
		ConnectionI.cpp
		ConnectionRequestHandler.cpp
		Connector.cpp
		ConnectRequestHandler.cpp
		CountDownLatch.cpp
		DefaultsAndOverrides.cpp
		DispatchInterceptor.cpp
		EndpointFactory.cpp
		EndpointFactoryManager.cpp
		EndpointI.cpp
		EventHandler.cpp
		Exception.cpp
		FactoryTable.cpp
		FactoryTableInit.cpp
		GCObject.cpp
		HttpParser.cpp
		ImplicitContextI.cpp
		Incoming.cpp
		IncomingAsync.cpp
		Initialize.cpp
		InputStream.cpp
		Instance.cpp
		InstrumentationI.cpp
		IPEndpointI.cpp
		LocalObject.cpp
		LocatorInfo.cpp
		LoggerAdminI.cpp
		LoggerI.cpp
		LoggerUtil.cpp
		MetricsAdminI.cpp
		MetricsObserverI.cpp
		Network.cpp
		NetworkProxy.cpp
		Object.cpp
		ObjectAdapterFactory.cpp
		ObjectAdapterI.cpp
		ObserverHelper.cpp
		OpaqueEndpointI.cpp
		OutgoingAsync.cpp
		OutputStream.cpp
		PluginManagerI.cpp
		PropertiesAdminI.cpp
		PropertiesI.cpp
		PropertyNames.cpp
		Protocol.cpp
		ProtocolInstance.cpp
		ProtocolPluginFacade.cpp
		Proxy.cpp
		ProxyFactory.cpp
		Reference.cpp
		ReferenceFactory.cpp
		RegisterPluginsInit.cpp
		RequestHandler.cpp
		RequestHandlerFactory.cpp
		Selector.cpp
		ServantManager.cpp
		SHA1.cpp
		SliceChecksums.cpp
		SlicedData.cpp
		StreamSocket.cpp
		StringConverterPlugin.cpp
		Thread.cpp
		ThreadPool.cpp
		Timer.cpp
		TraceLevels.cpp
		TraceUtil.cpp
		Transceiver.cpp
		UdpConnector.cpp
		UdpEndpointI.cpp
		UdpTransceiver.cpp
		TcpAcceptor.cpp
		TcpConnector.cpp
		TcpEndpointI.cpp
		TcpTransceiver.cpp
		Value.cpp
		ValueFactoryManagerI.cpp
		WSAcceptor.cpp
		WSConnector.cpp
		WSEndpoint.cpp
		WSTransceiver.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/ConvertUTF.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/FileUtil.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/InputUtil.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/MutexProtocol.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/Options.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/OutputUtil.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/Random.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/RecMutex.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/Shared.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/StringConverter.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/ConsoleUtil.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/StringUtil.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/ThreadException.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/Time.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/Unicode.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/UtilException.cpp
		${PROJECT_SOURCE_DIR}/cpp/src/IceUtil/UUID.cpp
	)
else()
	set(ICE_SOURCES
		Acceptor.cpp
		Acceptor.h
		AcceptorF.h
		ACM.cpp
		ACM.h
		ACMF.h
		Application.cpp
		ArgVector.cpp
		ArgVector.h
		AsyncResult.cpp
		Base64.cpp
		Base64.h
		BatchRequestQueue.cpp
		BatchRequestQueue.h
		Buffer.cpp
		CollocatedRequestHandler.cpp
		CollocatedRequestHandler.h
		CommunicatorI.cpp
		CommunicatorI.h
		Cond.cpp
		ConnectionFactory.cpp
		ConnectionFactory.h
		ConnectionFactoryF.h
		ConnectionI.cpp
		ConnectionI.h
		ConnectionRequestHandler.cpp
		ConnectionRequestHandler.h
		Connector.cpp
		Connector.h
		ConnectorF.h
		ConnectRequestHandler.cpp
		ConnectRequestHandler.h
		ConnectRequestHandlerF.h
		CountDownLatch.cpp
		DefaultsAndOverrides.cpp
		DefaultsAndOverrides.h
		DefaultsAndOverridesF.h
		DispatchInterceptor.cpp
		DLLMain.cpp
		DynamicLibrary.cpp
		EndpointFactory.cpp
		EndpointFactory.h
		EndpointFactoryF.h
		EndpointFactoryManager.cpp
		EndpointFactoryManager.h
		EndpointFactoryManagerF.h
		EndpointI.cpp
		EndpointI.h
		EndpointIF.h
		EventHandler.cpp
		EventHandler.h
		EventHandlerF.h
		Exception.cpp
		FactoryTable.cpp
		FactoryTableInit.cpp
		GCObject.cpp
		HashUtil.h
		HttpParser.cpp
		HttpParser.h
		IconvStringConverter.cpp
		ImplicitContextI.cpp
		ImplicitContextI.h
		Incoming.cpp
		IncomingAsync.cpp
		IncomingRequest.h
		Initialize.cpp
		InputStream.cpp
		Instance.cpp
		Instance.h
		InstrumentationI.cpp
		InstrumentationI.h
		IPEndpointI.cpp
		IPEndpointI.h
		IPEndpointIF.h
		LocalObject.cpp
		LocatorInfo.cpp
		LocatorInfo.h
		LocatorInfoF.h
		LoggerAdminI.cpp
		LoggerAdminI.h
		LoggerI.cpp
		LoggerI.h
		LoggerUtil.cpp
		MetricsAdminI.cpp
		MetricsObserverI.cpp
		Network.cpp
		Network.h
		NetworkF.h
		NetworkProxy.cpp
		NetworkProxy.h
		NetworkProxyF.h
		Object.cpp
		ObjectAdapterFactory.cpp
		ObjectAdapterFactory.h
		ObjectAdapterFactoryF.h
		ObjectAdapterI.cpp
		ObjectAdapterI.h
		ObserverHelper.cpp
		OpaqueEndpointI.cpp
		OpaqueEndpointI.h
		OutgoingAsync.cpp
		OutputStream.cpp
		PluginManagerI.cpp
		PluginManagerI.h
		PropertiesAdminI.cpp
		PropertiesAdminI.h
		PropertiesI.cpp
		PropertiesI.h
		PropertyNames.cpp
		PropertyNames.h
		Protocol.cpp
		ProtocolInstance.cpp
		ProtocolInstance.h
		ProtocolInstanceF.h
		ProtocolPluginFacade.cpp
		ProtocolPluginFacade.h
		ProtocolPluginFacadeF.h
		Proxy.cpp
		ProxyFactory.cpp
		ProxyFactory.h
		Reference.cpp
		Reference.h
		ReferenceFactory.cpp
		ReferenceFactory.h
		ReferenceFactoryF.h
		RegisterPluginsInit.cpp
		RegisterPluginsInit.h
		ReplyStatus.h
		RequestHandler.cpp
		RequestHandler.h
		RequestHandlerFactory.cpp
		RequestHandlerFactory.h
		ResponseHandler.cpp
		ResponseHandler.h
		RetryQueue.cpp
		RetryQueue.h
		RetryQueueF.h
		RouterInfo.cpp
		RouterInfo.h
		RouterInfoF.h
		Selector.cpp
		Selector.h
		ServantManager.cpp
		ServantManager.h
		Service.cpp
		SHA1.cpp
		SharedContext.h
		SliceChecksums.cpp
		SlicedData.cpp
		StreamSocket.cpp
		StreamSocket.h
		StringConverterPlugin.cpp
		StringUtil.h
		SysLoggerI.cpp
		SysLoggerI.h
		TcpAcceptor.cpp
		TcpAcceptor.h
		TcpConnector.cpp
		TcpConnector.h
		TcpEndpointI.cpp
		TcpEndpointI.h
		TcpTransceiver.cpp
		TcpTransceiver.h
		Thread.cpp
		ThreadPool.cpp
		ThreadPool.h
		Timer.cpp
		TraceLevels.cpp
		TraceLevels.h
		TraceLevelsF.h
		TraceUtil.cpp
		TraceUtil.h
		Transceiver.cpp
		Transceiver.h
		TransceiverF.h
		UdpConnector.cpp
		UdpConnector.h
		UdpEndpointI.cpp
		UdpEndpointI.h
		UdpTransceiver.cpp
		UdpTransceiver.h
		Value.cpp
		ValueFactoryManagerI.cpp
		ValueFactoryManagerI.h
		VirtualShared.h
		WSAcceptor.cpp
		WSAcceptor.h
		WSConnector.cpp
		WSConnector.h
		WSEndpoint.cpp
		WSEndpoint.h
		WSTransceiver.cpp
		WSTransceiver.h
	)
endif()

list(APPEND ICE_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICE_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "Ice")

foreach(slice ${ICE_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${GENERATED_SLICES_DIR}/Ice/${slice_name}.cpp 
		${GENERATED_SLICES_DIR}/Ice/${slice_name}.h
	)	
	#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice(slice2cpp
		"${ICE_SLICE_PARAMS}"
		"${ICE_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/Ice
		"${output_files}"
	)
endforeach()

install(DIRECTORY ${GENERATED_SLICES_DIR}/Ice 
	DESTINATION ${GENERATED_H_INSTALL_DIR}
	FILES_MATCHING PATTERN "*.h"
)

if(BUILD_ICE_CPP98)
	set(ICE_TARGET ice)
	add_library(${ICE_TARGET})
	set_target_properties(${ICE_TARGET} 
		PROPERTIES
			OUTPUT_NAME Ice${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
			LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS}
			CXX_STANDARD 98
	)
elseif(BUILD_ICE_CPP11)
	set(ICE_TARGET ice++11)
	add_library(${ICE_TARGET})
	set_target_properties(${ICE_TARGET} 
		PROPERTIES
			OUTPUT_NAME Ice${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS}
			CXX_STANDARD 11
	)
elseif(BUILD_ICE_UWP)
	set(ICE_TARGET iceuwp++11)
	add_library(${ICE_TARGET} STATIC)
	set_target_properties(${ICE_TARGET} 
		PROPERTIES
			OUTPUT_NAME Ice${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS}
			CXX_STANDARD 11
	)
endif()

target_sources(${ICE_TARGET} 
	PRIVATE 
		${ICE_SOURCES}
		${GENERATED_ICE_SOURCES}
		${GENERATED_ICE_HEADERS}
		${ICE_SLICES}
)

if(LINUX)
	target_sources(${ICE_TARGET}
		PRIVATE
			SystemdJournalI.cpp
			SystemdJournalI.h
	)
endif()

target_include_directories(${ICE_TARGET}
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${BZIP2_INCLUDE_DIR}
)

if(BUILD_ICE_CPP98)
	target_link_libraries(${ICE_TARGET}
		PRIVATE
			$<TARGET_OBJECTS:iceutil>
			BZip2::BZip2
	)
elseif(BUILD_ICE_CPP11)
	target_link_libraries(${ICE_TARGET}
		PRIVATE
			$<TARGET_OBJECTS:iceutil++11>
			BZip2::BZip2
	)
endif()

if(NOT BUILD_ICE_UWP)
	target_compile_definitions(${ICE_TARGET} 
		PRIVATE 
			${ICE_COMPILE_DEFS}
			"ICE_API_EXPORTS"
	)
else()
	target_compile_definitions(${ICE_TARGET} 
		PRIVATE 
			${ICE_COMPILE_DEFS}
			"ICE_BUILDING_ICE"
	)
endif()

if(MSVC)
	if(NOT BUILD_ICE_UWP)
		source_group(
			TREE ${CMAKE_CURRENT_SOURCE_DIR}
			PREFIX "Resource Files" 
			FILES
				Ice.rc
		)

		source_group("Resource Files/Generated"
			FILES
				${GENERATED_SLICES_DIR}/Ice/EventLoggerMsg.rc
		)

		source_group("Header Files/Generated"
			FILES
				${GENERATED_ICE_HEADERS}
				${GENERATED_SLICES_DIR}/Ice/EventLoggerMsg.h
		)

		target_sources(${ICE_TARGET}
			PRIVATE
				EventLoggerMsg.mc
				Ice.rc
				${GENERATED_ICE_RESOURCES}
		)
		
		target_link_libraries(${ICE_TARGET}
			PRIVATE
				advapi32.lib
				ws2_32.lib
				Iphlpapi.lib
				rpcrt4.lib
				DbgHelp.lib
				Shlwapi.lib
		)

		add_custom_command(
			OUTPUT 
				${GENERATED_SLICES_DIR}/Ice/EventLoggerMsg.rc 
				${GENERATED_SLICES_DIR}/Ice/EventLoggerMsg.h
			COMMAND ${CMAKE_MC_COMPILER} ${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
			WORKING_DIRECTORY ${GENERATED_SLICES_DIR}/Ice
			DEPENDS EventLoggerMsg.mc 
		)
	endif()

	source_group(
		TREE ${SLICE_DIR}/Ice
		PREFIX "Slice Files"
		FILES
			${ICE_SLICES}
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_ICE_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_ICE_HEADERS}
	)

	target_compile_options(${ICE_TARGET} 
		PRIVATE 
			"/wd4996" 
			${ICE_MSVC_COMPILE_OPTIONS} 
	)
endif()

install(TARGETS ${ICE_TARGET} 
	RUNTIME DESTINATION ${ICE_RUNTIME_INSTALL_DIR}
	LIBRARY DESTINATION ${ICE_LIBRARY_INSTALL_DIR}
	ARCHIVE DESTINATION ${ICE_ARCHIVE_INSTALL_DIR}
)
