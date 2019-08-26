add_library(${ICE_PROJECT_NAME})

if(NOT ${PROJECT_BINARY_DIR}/generated/Ice)
	file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/Ice)
endif()

set(GENERATED_ICE_SOURCES_DIR ${PROJECT_BINARY_DIR}/generated/Ice)

set(GENERATED_ICE_SOURCES
	${GENERATED_ICE_SOURCES_DIR}/BuiltinSequences.cpp
	${GENERATED_ICE_SOURCES_DIR}/BuiltinSequences.h
	${GENERATED_ICE_SOURCES_DIR}/Communicator.cpp
	${GENERATED_ICE_SOURCES_DIR}/Communicator.h
	${GENERATED_ICE_SOURCES_DIR}/CommunicatorF.cpp
	${GENERATED_ICE_SOURCES_DIR}/CommunicatorF.h
	${GENERATED_ICE_SOURCES_DIR}/Connection.cpp
	${GENERATED_ICE_SOURCES_DIR}/Connection.h
	${GENERATED_ICE_SOURCES_DIR}/ConnectionF.cpp
	${GENERATED_ICE_SOURCES_DIR}/ConnectionF.h
	${GENERATED_ICE_SOURCES_DIR}/Current.cpp
	${GENERATED_ICE_SOURCES_DIR}/Current.h
	${GENERATED_ICE_SOURCES_DIR}/Endpoint.cpp
	${GENERATED_ICE_SOURCES_DIR}/Endpoint.h
	${GENERATED_ICE_SOURCES_DIR}/EndpointF.cpp
	${GENERATED_ICE_SOURCES_DIR}/EndpointF.h
	${GENERATED_ICE_SOURCES_DIR}/EndpointTypes.cpp
	${GENERATED_ICE_SOURCES_DIR}/EndpointTypes.h
	${GENERATED_ICE_SOURCES_DIR}/EventLoggerMsg.h
	${GENERATED_ICE_SOURCES_DIR}/EventLoggerMsg.rc
	${GENERATED_ICE_SOURCES_DIR}/FacetMap.cpp
	${GENERATED_ICE_SOURCES_DIR}/FacetMap.h
	${GENERATED_ICE_SOURCES_DIR}/Identity.cpp
	${GENERATED_ICE_SOURCES_DIR}/Identity.h
	${GENERATED_ICE_SOURCES_DIR}/ImplicitContext.cpp
	${GENERATED_ICE_SOURCES_DIR}/ImplicitContext.h
	${GENERATED_ICE_SOURCES_DIR}/ImplicitContextF.cpp
	${GENERATED_ICE_SOURCES_DIR}/ImplicitContextF.h
	${GENERATED_ICE_SOURCES_DIR}/Instrumentation.cpp
	${GENERATED_ICE_SOURCES_DIR}/Instrumentation.h
	${GENERATED_ICE_SOURCES_DIR}/InstrumentationF.cpp
	${GENERATED_ICE_SOURCES_DIR}/InstrumentationF.h
	${GENERATED_ICE_SOURCES_DIR}/LocalException.cpp
	${GENERATED_ICE_SOURCES_DIR}/LocalException.h
	${GENERATED_ICE_SOURCES_DIR}/Locator.cpp
	${GENERATED_ICE_SOURCES_DIR}/Locator.h
	${GENERATED_ICE_SOURCES_DIR}/LocatorF.cpp
	${GENERATED_ICE_SOURCES_DIR}/LocatorF.h
	${GENERATED_ICE_SOURCES_DIR}/Logger.cpp
	${GENERATED_ICE_SOURCES_DIR}/Logger.h
	${GENERATED_ICE_SOURCES_DIR}/LoggerF.cpp
	${GENERATED_ICE_SOURCES_DIR}/LoggerF.h
	${GENERATED_ICE_SOURCES_DIR}/Metrics.cpp
	${GENERATED_ICE_SOURCES_DIR}/Metrics.h
	${GENERATED_ICE_SOURCES_DIR}/ObjectAdapter.cpp
	${GENERATED_ICE_SOURCES_DIR}/ObjectAdapter.h
	${GENERATED_ICE_SOURCES_DIR}/ObjectAdapterF.cpp
	${GENERATED_ICE_SOURCES_DIR}/ObjectAdapterF.h
	${GENERATED_ICE_SOURCES_DIR}/ObjectFactory.cpp
	${GENERATED_ICE_SOURCES_DIR}/ObjectFactory.h
	${GENERATED_ICE_SOURCES_DIR}/Plugin.cpp
	${GENERATED_ICE_SOURCES_DIR}/Plugin.h
	${GENERATED_ICE_SOURCES_DIR}/PluginF.cpp
	${GENERATED_ICE_SOURCES_DIR}/PluginF.h
	${GENERATED_ICE_SOURCES_DIR}/Process.cpp
	${GENERATED_ICE_SOURCES_DIR}/Process.h
	${GENERATED_ICE_SOURCES_DIR}/ProcessF.cpp
	${GENERATED_ICE_SOURCES_DIR}/ProcessF.h
	${GENERATED_ICE_SOURCES_DIR}/Properties.cpp
	${GENERATED_ICE_SOURCES_DIR}/Properties.h
	${GENERATED_ICE_SOURCES_DIR}/PropertiesAdmin.cpp
	${GENERATED_ICE_SOURCES_DIR}/PropertiesAdmin.h
	${GENERATED_ICE_SOURCES_DIR}/PropertiesF.cpp
	${GENERATED_ICE_SOURCES_DIR}/PropertiesF.h
	${GENERATED_ICE_SOURCES_DIR}/RemoteLogger.cpp
	${GENERATED_ICE_SOURCES_DIR}/RemoteLogger.h
	${GENERATED_ICE_SOURCES_DIR}/Router.cpp
	${GENERATED_ICE_SOURCES_DIR}/Router.h
	${GENERATED_ICE_SOURCES_DIR}/RouterF.cpp
	${GENERATED_ICE_SOURCES_DIR}/RouterF.h
	${GENERATED_ICE_SOURCES_DIR}/ServantLocator.cpp
	${GENERATED_ICE_SOURCES_DIR}/ServantLocator.h
	${GENERATED_ICE_SOURCES_DIR}/ServantLocatorF.cpp
	${GENERATED_ICE_SOURCES_DIR}/ServantLocatorF.h
	${GENERATED_ICE_SOURCES_DIR}/SliceChecksumDict.cpp
	${GENERATED_ICE_SOURCES_DIR}/SliceChecksumDict.h
	${GENERATED_ICE_SOURCES_DIR}/ValueFactory.cpp
	${GENERATED_ICE_SOURCES_DIR}/ValueFactory.h
	${GENERATED_ICE_SOURCES_DIR}/Version.cpp
	${GENERATED_ICE_SOURCES_DIR}/Version.h
)

set(ICE_SLICES
	${SLICE_DIR}/Ice/BuiltinSequences.ice
	${SLICE_DIR}/Ice/Communicator.ice
	${SLICE_DIR}/Ice/CommunicatorF.ice
	${SLICE_DIR}/Ice/Connection.ice
	${SLICE_DIR}/Ice/ConnectionF.ice
	${SLICE_DIR}/Ice/Current.ice
	${SLICE_DIR}/Ice/Endpoint.ice
	${SLICE_DIR}/Ice/EndpointF.ice
	${SLICE_DIR}/Ice/EndpointTypes.ice
	${SLICE_DIR}/Ice/FacetMap.ice
	${SLICE_DIR}/Ice/Identity.ice
	${SLICE_DIR}/Ice/ImplicitContext.ice
	${SLICE_DIR}/Ice/ImplicitContextF.ice
	${SLICE_DIR}/Ice/Instrumentation.ice
	${SLICE_DIR}/Ice/InstrumentationF.ice
	${SLICE_DIR}/Ice/LocalException.ice
	${SLICE_DIR}/Ice/Locator.ice
	${SLICE_DIR}/Ice/LocatorF.ice
	${SLICE_DIR}/Ice/Logger.ice
	${SLICE_DIR}/Ice/LoggerF.ice
	${SLICE_DIR}/Ice/Metrics.ice
	${SLICE_DIR}/Ice/ObjectAdapter.ice
	${SLICE_DIR}/Ice/ObjectAdapterF.ice
	${SLICE_DIR}/Ice/ObjectFactory.ice
	${SLICE_DIR}/Ice/Plugin.ice
	${SLICE_DIR}/Ice/PluginF.ice
	${SLICE_DIR}/Ice/Process.ice
	${SLICE_DIR}/Ice/ProcessF.ice
	${SLICE_DIR}/Ice/Properties.ice
	${SLICE_DIR}/Ice/PropertiesAdmin.ice
	${SLICE_DIR}/Ice/PropertiesF.ice
	${SLICE_DIR}/Ice/RemoteLogger.ice
	${SLICE_DIR}/Ice/Router.ice
	${SLICE_DIR}/Ice/RouterF.ice
	${SLICE_DIR}/Ice/ServantLocator.ice
	${SLICE_DIR}/Ice/ServantLocatorF.ice
	${SLICE_DIR}/Ice/SliceChecksumDict.ice
	${SLICE_DIR}/Ice/ValueFactory.ice
	${SLICE_DIR}/Ice/Version.ice
)

set_source_files_properties(${GENERATED_ICE_SOURCES} PROPERTIES GENERATED TRUE)

target_sources(${ICE_PROJECT_NAME}
   PRIVATE
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
		CMakeLists.txt
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
		EventLoggerMsg.mc
		Exception.cpp
		FactoryTable.cpp
		FactoryTableInit.cpp
		GCObject.cpp
		HashUtil.h
		HttpParser.cpp
		HttpParser.h
		Ice.rc
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
		Makefile.mk
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
		SystemdJournalI.cpp
		SystemdJournalI.h
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
		${GENERATED_ICE_SOURCES}
		${ICE_SLICES}
)

find_package(BZip2 REQUIRED)
add_dependencies(${ICE_PROJECT_NAME} slice2cpp)

target_include_directories(${ICE_PROJECT_NAME}
	PRIVATE 
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${PROJECT_BINARY_DIR}/generated
		#${GENERATED_ICE_SOURCES_DIR}
		${BZIP2_INCLUDE_DIR}
)


if(CMAKE_CXX_STANDARD EQUAL 11)
	set(ICELIB_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
else()
	set(ICELIB_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS")
endif()

if(WIN32)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files" 
		FILES
			${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
			${CMAKE_CURRENT_SOURCE_DIR}/Ice.rc
	)

	source_group(
		TREE ${SLICE_DIR}/Ice
		PREFIX "Slice Files"
		FILES
			${ICE_SLICES}
	)

	source_group(
		TREE ${GENERATED_ICE_SOURCES_DIR}
		PREFIX "Generated Sources"
		FILES
			${GENERATED_ICE_SOURCES}
	)

	target_compile_options(${ICE_PROJECT_NAME} PRIVATE 
		"/wd4996" 
		${ICE_COMPILE_OPTIONS} 
	)

	target_compile_definitions(${ICE_PROJECT_NAME} PRIVATE 
		${ICELIB_COMPILE_DEFS}
		"ICE_API_EXPORTS"
	)

	if(BUILD_SHARED_LIBS)
		target_link_libraries(${ICE_PROJECT_NAME}
			PRIVATE
				advapi32.lib
				ws2_32.lib
				Iphlpapi.lib
				rpcrt4.lib
				DbgHelp.lib
				Shlwapi.lib
		)
	endif()

	target_link_libraries(${ICE_PROJECT_NAME}
		PRIVATE
		${ICE_ADDITIONAL_DEPS}
	)

	add_custom_command(TARGET ${ICE_PROJECT_NAME}
		COMMAND ${CMAKE_MC_COMPILER} ${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
		WORKING_DIRECTORY ${GENERATED_ICE_SOURCES_DIR}
		PRE_BUILD
		DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
	)
endif()

foreach(slice ${ICE_SLICES})
	#function(CompileSlices slice2_bin slice_path ice_file slice_target output_dir)
	CompileSlices(slice2cpp
		${SLICE_DIR}
		${slice}
		${ICE_PROJECT_NAME}
		${GENERATED_ICE_SOURCES_DIR}
	)
endforeach()

install(TARGETS ${ICE_PROJECT_NAME} DESTINATION lib)
