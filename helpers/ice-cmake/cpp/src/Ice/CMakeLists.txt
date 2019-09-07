if(NOT ${PROJECT_BINARY_DIR}/generated/Ice)
	file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/Ice)
endif()

set(GENERATED_ICE_SOURCES_DIR ${PROJECT_BINARY_DIR}/generated/Ice)

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

set(GENERATED_ICE_HEADERS
	${GENERATED_ICE_SOURCES_DIR}/BuiltinSequences.h
	${GENERATED_ICE_SOURCES_DIR}/Communicator.h
	${GENERATED_ICE_SOURCES_DIR}/CommunicatorF.h
	${GENERATED_ICE_SOURCES_DIR}/Connection.h
	${GENERATED_ICE_SOURCES_DIR}/ConnectionF.h
	${GENERATED_ICE_SOURCES_DIR}/Current.h
	${GENERATED_ICE_SOURCES_DIR}/Endpoint.h
	${GENERATED_ICE_SOURCES_DIR}/EndpointF.h
	${GENERATED_ICE_SOURCES_DIR}/EndpointTypes.h
	${GENERATED_ICE_SOURCES_DIR}/FacetMap.h
	${GENERATED_ICE_SOURCES_DIR}/Identity.h
	${GENERATED_ICE_SOURCES_DIR}/ImplicitContext.h
	${GENERATED_ICE_SOURCES_DIR}/ImplicitContextF.h
	${GENERATED_ICE_SOURCES_DIR}/Instrumentation.h
	${GENERATED_ICE_SOURCES_DIR}/InstrumentationF.h
	${GENERATED_ICE_SOURCES_DIR}/LocalException.h
	${GENERATED_ICE_SOURCES_DIR}/Locator.h
	${GENERATED_ICE_SOURCES_DIR}/LocatorF.h
	${GENERATED_ICE_SOURCES_DIR}/Logger.h
	${GENERATED_ICE_SOURCES_DIR}/LoggerF.h
	${GENERATED_ICE_SOURCES_DIR}/Metrics.h
	${GENERATED_ICE_SOURCES_DIR}/ObjectAdapter.h
	${GENERATED_ICE_SOURCES_DIR}/ObjectAdapterF.h
	${GENERATED_ICE_SOURCES_DIR}/ObjectFactory.h
	${GENERATED_ICE_SOURCES_DIR}/Plugin.h
	${GENERATED_ICE_SOURCES_DIR}/PluginF.h
	${GENERATED_ICE_SOURCES_DIR}/Process.h
	${GENERATED_ICE_SOURCES_DIR}/ProcessF.h
	${GENERATED_ICE_SOURCES_DIR}/Properties.h
	${GENERATED_ICE_SOURCES_DIR}/PropertiesAdmin.h
	${GENERATED_ICE_SOURCES_DIR}/PropertiesF.h
	${GENERATED_ICE_SOURCES_DIR}/RemoteLogger.h
	${GENERATED_ICE_SOURCES_DIR}/Router.h
	${GENERATED_ICE_SOURCES_DIR}/RouterF.h
	${GENERATED_ICE_SOURCES_DIR}/ServantLocator.h
	${GENERATED_ICE_SOURCES_DIR}/ServantLocatorF.h
	${GENERATED_ICE_SOURCES_DIR}/SliceChecksumDict.h
	${GENERATED_ICE_SOURCES_DIR}/ValueFactory.h
	${GENERATED_ICE_SOURCES_DIR}/Version.h
)

set(GENERATED_ICE_SOURCES
	${GENERATED_ICE_SOURCES_DIR}/BuiltinSequences.cpp
	${GENERATED_ICE_SOURCES_DIR}/Communicator.cpp
	${GENERATED_ICE_SOURCES_DIR}/CommunicatorF.cpp
	${GENERATED_ICE_SOURCES_DIR}/Connection.cpp
	${GENERATED_ICE_SOURCES_DIR}/ConnectionF.cpp
	${GENERATED_ICE_SOURCES_DIR}/Current.cpp
	${GENERATED_ICE_SOURCES_DIR}/Endpoint.cpp
	${GENERATED_ICE_SOURCES_DIR}/EndpointF.cpp
	${GENERATED_ICE_SOURCES_DIR}/EndpointTypes.cpp
	${GENERATED_ICE_SOURCES_DIR}/FacetMap.cpp
	${GENERATED_ICE_SOURCES_DIR}/Identity.cpp
	${GENERATED_ICE_SOURCES_DIR}/ImplicitContext.cpp
	${GENERATED_ICE_SOURCES_DIR}/ImplicitContextF.cpp
	${GENERATED_ICE_SOURCES_DIR}/Instrumentation.cpp
	${GENERATED_ICE_SOURCES_DIR}/InstrumentationF.cpp
	${GENERATED_ICE_SOURCES_DIR}/LocalException.cpp
	${GENERATED_ICE_SOURCES_DIR}/Locator.cpp
	${GENERATED_ICE_SOURCES_DIR}/LocatorF.cpp
	${GENERATED_ICE_SOURCES_DIR}/Logger.cpp
	${GENERATED_ICE_SOURCES_DIR}/LoggerF.cpp
	${GENERATED_ICE_SOURCES_DIR}/Metrics.cpp
	${GENERATED_ICE_SOURCES_DIR}/ObjectAdapter.cpp
	${GENERATED_ICE_SOURCES_DIR}/ObjectAdapterF.cpp
	${GENERATED_ICE_SOURCES_DIR}/ObjectFactory.cpp
	${GENERATED_ICE_SOURCES_DIR}/Plugin.cpp
	${GENERATED_ICE_SOURCES_DIR}/PluginF.cpp
	${GENERATED_ICE_SOURCES_DIR}/Process.cpp
	${GENERATED_ICE_SOURCES_DIR}/ProcessF.cpp
	${GENERATED_ICE_SOURCES_DIR}/Properties.cpp
	${GENERATED_ICE_SOURCES_DIR}/PropertiesAdmin.cpp
	${GENERATED_ICE_SOURCES_DIR}/PropertiesF.cpp
	${GENERATED_ICE_SOURCES_DIR}/RemoteLogger.cpp
	${GENERATED_ICE_SOURCES_DIR}/Router.cpp
	${GENERATED_ICE_SOURCES_DIR}/RouterF.cpp
	${GENERATED_ICE_SOURCES_DIR}/ServantLocator.cpp
	${GENERATED_ICE_SOURCES_DIR}/ServantLocatorF.cpp
	${GENERATED_ICE_SOURCES_DIR}/SliceChecksumDict.cpp
	${GENERATED_ICE_SOURCES_DIR}/ValueFactory.cpp
	${GENERATED_ICE_SOURCES_DIR}/Version.cpp
)

set_source_files_properties(
	${GENERATED_ICE_SOURCES} 
	${GENERATED_ICE_HEADERS} 
	PROPERTIES 
		GENERATED TRUE
)

if(WIN32)
	set(GENERATED_ICE_RESOURCES
		${GENERATED_ICE_SOURCES_DIR}/EventLoggerMsg.h
		${GENERATED_ICE_SOURCES_DIR}/EventLoggerMsg.rc
	)

	set_source_files_properties(${GENERATED_ICE_RESOURCES} PROPERTIES GENERATED TRUE)
endif()

add_library(ice)

target_sources(ice
	PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/Acceptor.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Acceptor.h
		${CMAKE_CURRENT_SOURCE_DIR}/AcceptorF.h
		${CMAKE_CURRENT_SOURCE_DIR}/ACM.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ACM.h
		${CMAKE_CURRENT_SOURCE_DIR}/ACMF.h
		${CMAKE_CURRENT_SOURCE_DIR}/Application.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ArgVector.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ArgVector.h
		${CMAKE_CURRENT_SOURCE_DIR}/AsyncResult.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Base64.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Base64.h
		${CMAKE_CURRENT_SOURCE_DIR}/BatchRequestQueue.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/BatchRequestQueue.h
		${CMAKE_CURRENT_SOURCE_DIR}/Buffer.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/CollocatedRequestHandler.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/CollocatedRequestHandler.h
		${CMAKE_CURRENT_SOURCE_DIR}/CommunicatorI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/CommunicatorI.h
		${CMAKE_CURRENT_SOURCE_DIR}/Cond.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectionFactory.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectionFactory.h
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectionFactoryF.h
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectionI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectionI.h
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectionRequestHandler.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectionRequestHandler.h
		${CMAKE_CURRENT_SOURCE_DIR}/Connector.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Connector.h
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectorF.h
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectRequestHandler.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectRequestHandler.h
		${CMAKE_CURRENT_SOURCE_DIR}/ConnectRequestHandlerF.h
		${CMAKE_CURRENT_SOURCE_DIR}/CountDownLatch.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/DefaultsAndOverrides.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/DefaultsAndOverrides.h
		${CMAKE_CURRENT_SOURCE_DIR}/DefaultsAndOverridesF.h
		${CMAKE_CURRENT_SOURCE_DIR}/DispatchInterceptor.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/DLLMain.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/DynamicLibrary.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/EndpointFactory.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/EndpointFactory.h
		${CMAKE_CURRENT_SOURCE_DIR}/EndpointFactoryF.h
		${CMAKE_CURRENT_SOURCE_DIR}/EndpointFactoryManager.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/EndpointFactoryManager.h
		${CMAKE_CURRENT_SOURCE_DIR}/EndpointFactoryManagerF.h
		${CMAKE_CURRENT_SOURCE_DIR}/EndpointI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/EndpointI.h
		${CMAKE_CURRENT_SOURCE_DIR}/EndpointIF.h
		${CMAKE_CURRENT_SOURCE_DIR}/EventHandler.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/EventHandler.h
		${CMAKE_CURRENT_SOURCE_DIR}/EventHandlerF.h
		${CMAKE_CURRENT_SOURCE_DIR}/Exception.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/FactoryTable.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/FactoryTableInit.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/GCObject.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/HashUtil.h
		${CMAKE_CURRENT_SOURCE_DIR}/HttpParser.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/HttpParser.h
		${CMAKE_CURRENT_SOURCE_DIR}/IconvStringConverter.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ImplicitContextI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ImplicitContextI.h
		${CMAKE_CURRENT_SOURCE_DIR}/Incoming.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/IncomingAsync.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/IncomingRequest.h
		${CMAKE_CURRENT_SOURCE_DIR}/Initialize.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/InputStream.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Instance.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Instance.h
		${CMAKE_CURRENT_SOURCE_DIR}/InstrumentationI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/InstrumentationI.h
		${CMAKE_CURRENT_SOURCE_DIR}/IPEndpointI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/IPEndpointI.h
		${CMAKE_CURRENT_SOURCE_DIR}/IPEndpointIF.h
		${CMAKE_CURRENT_SOURCE_DIR}/LocalObject.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/LocatorInfo.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/LocatorInfo.h
		${CMAKE_CURRENT_SOURCE_DIR}/LocatorInfoF.h
		${CMAKE_CURRENT_SOURCE_DIR}/LoggerAdminI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/LoggerAdminI.h
		${CMAKE_CURRENT_SOURCE_DIR}/LoggerI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/LoggerI.h
		${CMAKE_CURRENT_SOURCE_DIR}/LoggerUtil.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/MetricsAdminI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/MetricsObserverI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Network.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Network.h
		${CMAKE_CURRENT_SOURCE_DIR}/NetworkF.h
		${CMAKE_CURRENT_SOURCE_DIR}/NetworkProxy.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/NetworkProxy.h
		${CMAKE_CURRENT_SOURCE_DIR}/NetworkProxyF.h
		${CMAKE_CURRENT_SOURCE_DIR}/Object.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ObjectAdapterFactory.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ObjectAdapterFactory.h
		${CMAKE_CURRENT_SOURCE_DIR}/ObjectAdapterFactoryF.h
		${CMAKE_CURRENT_SOURCE_DIR}/ObjectAdapterI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ObjectAdapterI.h
		${CMAKE_CURRENT_SOURCE_DIR}/ObserverHelper.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/OpaqueEndpointI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/OpaqueEndpointI.h
		${CMAKE_CURRENT_SOURCE_DIR}/OutgoingAsync.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/OutputStream.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/PluginManagerI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/PluginManagerI.h
		${CMAKE_CURRENT_SOURCE_DIR}/PropertiesAdminI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/PropertiesAdminI.h
		${CMAKE_CURRENT_SOURCE_DIR}/PropertiesI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/PropertiesI.h
		${CMAKE_CURRENT_SOURCE_DIR}/PropertyNames.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/PropertyNames.h
		${CMAKE_CURRENT_SOURCE_DIR}/Protocol.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ProtocolInstance.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ProtocolInstance.h
		${CMAKE_CURRENT_SOURCE_DIR}/ProtocolInstanceF.h
		${CMAKE_CURRENT_SOURCE_DIR}/ProtocolPluginFacade.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ProtocolPluginFacade.h
		${CMAKE_CURRENT_SOURCE_DIR}/ProtocolPluginFacadeF.h
		${CMAKE_CURRENT_SOURCE_DIR}/Proxy.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ProxyFactory.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ProxyFactory.h
		${CMAKE_CURRENT_SOURCE_DIR}/Reference.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Reference.h
		${CMAKE_CURRENT_SOURCE_DIR}/ReferenceFactory.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ReferenceFactory.h
		${CMAKE_CURRENT_SOURCE_DIR}/ReferenceFactoryF.h
		${CMAKE_CURRENT_SOURCE_DIR}/RegisterPluginsInit.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/RegisterPluginsInit.h
		${CMAKE_CURRENT_SOURCE_DIR}/ReplyStatus.h
		${CMAKE_CURRENT_SOURCE_DIR}/RequestHandler.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/RequestHandler.h
		${CMAKE_CURRENT_SOURCE_DIR}/RequestHandlerFactory.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/RequestHandlerFactory.h
		${CMAKE_CURRENT_SOURCE_DIR}/ResponseHandler.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ResponseHandler.h
		${CMAKE_CURRENT_SOURCE_DIR}/RetryQueue.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/RetryQueue.h
		${CMAKE_CURRENT_SOURCE_DIR}/RetryQueueF.h
		${CMAKE_CURRENT_SOURCE_DIR}/RouterInfo.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/RouterInfo.h
		${CMAKE_CURRENT_SOURCE_DIR}/RouterInfoF.h
		${CMAKE_CURRENT_SOURCE_DIR}/Selector.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Selector.h
		${CMAKE_CURRENT_SOURCE_DIR}/ServantManager.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ServantManager.h
		${CMAKE_CURRENT_SOURCE_DIR}/Service.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/SHA1.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/SharedContext.h
		${CMAKE_CURRENT_SOURCE_DIR}/SliceChecksums.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/SlicedData.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/StreamSocket.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/StreamSocket.h
		${CMAKE_CURRENT_SOURCE_DIR}/StringConverterPlugin.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/StringUtil.h
		${CMAKE_CURRENT_SOURCE_DIR}/SysLoggerI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/SysLoggerI.h
		${CMAKE_CURRENT_SOURCE_DIR}/SystemdJournalI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/SystemdJournalI.h
		${CMAKE_CURRENT_SOURCE_DIR}/TcpAcceptor.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/TcpAcceptor.h
		${CMAKE_CURRENT_SOURCE_DIR}/TcpConnector.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/TcpConnector.h
		${CMAKE_CURRENT_SOURCE_DIR}/TcpEndpointI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/TcpEndpointI.h
		${CMAKE_CURRENT_SOURCE_DIR}/TcpTransceiver.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/TcpTransceiver.h
		${CMAKE_CURRENT_SOURCE_DIR}/Thread.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ThreadPool.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ThreadPool.h
		${CMAKE_CURRENT_SOURCE_DIR}/Timer.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/TraceLevels.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/TraceLevels.h
		${CMAKE_CURRENT_SOURCE_DIR}/TraceLevelsF.h
		${CMAKE_CURRENT_SOURCE_DIR}/TraceUtil.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/TraceUtil.h
		${CMAKE_CURRENT_SOURCE_DIR}/Transceiver.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/Transceiver.h
		${CMAKE_CURRENT_SOURCE_DIR}/TransceiverF.h
		${CMAKE_CURRENT_SOURCE_DIR}/UdpConnector.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/UdpConnector.h
		${CMAKE_CURRENT_SOURCE_DIR}/UdpEndpointI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/UdpEndpointI.h
		${CMAKE_CURRENT_SOURCE_DIR}/UdpTransceiver.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/UdpTransceiver.h
		${CMAKE_CURRENT_SOURCE_DIR}/Value.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ValueFactoryManagerI.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/ValueFactoryManagerI.h
		${CMAKE_CURRENT_SOURCE_DIR}/VirtualShared.h
		${CMAKE_CURRENT_SOURCE_DIR}/WSAcceptor.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/WSAcceptor.h
		${CMAKE_CURRENT_SOURCE_DIR}/WSConnector.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/WSConnector.h
		${CMAKE_CURRENT_SOURCE_DIR}/WSEndpoint.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/WSEndpoint.h
		${CMAKE_CURRENT_SOURCE_DIR}/WSTransceiver.cpp
		${CMAKE_CURRENT_SOURCE_DIR}/WSTransceiver.h
		${GENERATED_ICE_SOURCES}
		${GENERATED_ICE_HEADERS}
		${ICE_SLICES}
)

target_include_directories(ice
	PRIVATE 
		${PROJECT_BINARY_DIR}/generated
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${BZIP2_INCLUDE_DIR}
)

# todo - if *nix and Darwin need to include generated/Ice, define here

add_dependencies(ice slice2cpp)

if(CMAKE_CXX_STANDARD EQUAL 11)
	set(ICELIB_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
elseif(CMAKE_CXX_STANDARD EQUAL 98)
	set(ICELIB_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS}")
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
		TREE ${GENERATED_ICE_SOURCES_DIR}
		PREFIX "Resource Files/Generated"
		FILES
			${GENERATED_ICE_SOURCES_DIR}/EventLoggerMsg.rc
	)

	source_group(
		TREE ${SLICE_DIR}/Ice
		PREFIX "Slice Files"
		FILES
			${ICE_SLICES}
	)

	source_group(
		TREE ${GENERATED_ICE_SOURCES_DIR}
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_ICE_SOURCES}
	)

	source_group(
		TREE ${GENERATED_ICE_SOURCES_DIR}
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_ICE_HEADERS}
			${GENERATED_ICE_SOURCES_DIR}/EventLoggerMsg.h
	)

	target_compile_options(ice 
		PRIVATE 
			"/wd4996" 
			${ICE_COMPILE_OPTIONS} 
	)

	if(BUILD_SHARED_LIBS)
		target_link_libraries(ice
			PRIVATE
				advapi32.lib
				ws2_32.lib
				Iphlpapi.lib
				rpcrt4.lib
				DbgHelp.lib
				Shlwapi.lib
		)
	endif()
	
	target_sources(ice
		PRIVATE
		${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
		${GENERATED_ICE_RESOURCES}
	)

	add_custom_command(TARGET ice
		COMMAND ${CMAKE_MC_COMPILER} ${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
		WORKING_DIRECTORY ${GENERATED_ICE_SOURCES_DIR}
		PRE_BUILD
		DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
	)
endif()

target_compile_definitions(ice 
	PRIVATE 
		${ICELIB_COMPILE_DEFS}
		"ICE_API_EXPORTS"
)

foreach(slice ${ICE_SLICES})
	#function(CompileSlices slice2_bin slice_path ice_file slice_target include_dir output_dir)
	CompileSlices(slice2cpp
		${SLICE_DIR}
		${slice}
		ice
		Ice
		${GENERATED_ICE_SOURCES_DIR}
	)
endforeach()

if(CMAKE_CXX_STANDARD EQUAL 11)
	set_target_properties(ice 
		PROPERTIES
			OUTPUT_NAME ice${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
	)
elseif(CMAKE_CXX_STANDARD EQUAL 98)
	set_target_properties(ice 
		PROPERTIES
			OUTPUT_NAME ice${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
	)
endif()

install(TARGETS ice DESTINATION lib)
