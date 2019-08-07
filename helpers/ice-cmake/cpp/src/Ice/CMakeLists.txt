add_library(ice)

if(NOT ${CMAKE_CURRENT_BINARY_DIR}/generated/Ice)
	file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/generated/Ice)
endif()

set(GENERATED_SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/generated)

set(GENERATED_ICE_SOURCES
	${GENERATED_SOURCE_DIR}/Ice/BuiltinSequences.cpp
	${GENERATED_SOURCE_DIR}/Ice/BuiltinSequences.h
	${GENERATED_SOURCE_DIR}/Ice/BuiltinSequencesI.cpp
	${GENERATED_SOURCE_DIR}/Ice/BuiltinSequencesI.h
	${GENERATED_SOURCE_DIR}/Ice/Communicator.cpp
	${GENERATED_SOURCE_DIR}/Ice/Communicator.h
	${GENERATED_SOURCE_DIR}/Ice/CommunicatorF.cpp
	${GENERATED_SOURCE_DIR}/Ice/CommunicatorF.h
	${GENERATED_SOURCE_DIR}/Ice/CommunicatorFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/CommunicatorFI.h
	${GENERATED_SOURCE_DIR}/Ice/CommunicatorI.cpp
	${GENERATED_SOURCE_DIR}/Ice/CommunicatorI.h
	${GENERATED_SOURCE_DIR}/Ice/Connection.cpp
	${GENERATED_SOURCE_DIR}/Ice/Connection.h
	${GENERATED_SOURCE_DIR}/Ice/ConnectionF.cpp
	${GENERATED_SOURCE_DIR}/Ice/ConnectionF.h
	${GENERATED_SOURCE_DIR}/Ice/ConnectionFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ConnectionFI.h
	${GENERATED_SOURCE_DIR}/Ice/ConnectionI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ConnectionI.h
	${GENERATED_SOURCE_DIR}/Ice/Current.cpp
	${GENERATED_SOURCE_DIR}/Ice/Current.h
	${GENERATED_SOURCE_DIR}/Ice/CurrentI.cpp
	${GENERATED_SOURCE_DIR}/Ice/CurrentI.h
	${GENERATED_SOURCE_DIR}/Ice/Endpoint.cpp
	${GENERATED_SOURCE_DIR}/Ice/Endpoint.h
	${GENERATED_SOURCE_DIR}/Ice/EndpointF.cpp
	${GENERATED_SOURCE_DIR}/Ice/EndpointF.h
	${GENERATED_SOURCE_DIR}/Ice/EndpointFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/EndpointFI.h
	${GENERATED_SOURCE_DIR}/Ice/EndpointI.cpp
	${GENERATED_SOURCE_DIR}/Ice/EndpointI.h
	${GENERATED_SOURCE_DIR}/Ice/EndpointTypes.cpp
	${GENERATED_SOURCE_DIR}/Ice/EndpointTypes.h
	${GENERATED_SOURCE_DIR}/Ice/EndpointTypesI.cpp
	${GENERATED_SOURCE_DIR}/Ice/EndpointTypesI.h
	${GENERATED_SOURCE_DIR}/Ice/EventLoggerMsg.h
	${GENERATED_SOURCE_DIR}/Ice/EventLoggerMsg.rc
	${GENERATED_SOURCE_DIR}/Ice/FacetMap.cpp
	${GENERATED_SOURCE_DIR}/Ice/FacetMap.h
	${GENERATED_SOURCE_DIR}/Ice/FacetMapI.cpp
	${GENERATED_SOURCE_DIR}/Ice/FacetMapI.h
	${GENERATED_SOURCE_DIR}/Ice/Identity.cpp
	${GENERATED_SOURCE_DIR}/Ice/Identity.h
	${GENERATED_SOURCE_DIR}/Ice/IdentityI.cpp
	${GENERATED_SOURCE_DIR}/Ice/IdentityI.h
	${GENERATED_SOURCE_DIR}/Ice/ImplicitContext.cpp
	${GENERATED_SOURCE_DIR}/Ice/ImplicitContext.h
	${GENERATED_SOURCE_DIR}/Ice/ImplicitContextF.cpp
	${GENERATED_SOURCE_DIR}/Ice/ImplicitContextF.h
	${GENERATED_SOURCE_DIR}/Ice/ImplicitContextFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ImplicitContextFI.h
	${GENERATED_SOURCE_DIR}/Ice/ImplicitContextI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ImplicitContextI.h
	${GENERATED_SOURCE_DIR}/Ice/Instrumentation.cpp
	${GENERATED_SOURCE_DIR}/Ice/Instrumentation.h
	${GENERATED_SOURCE_DIR}/Ice/InstrumentationF.cpp
	${GENERATED_SOURCE_DIR}/Ice/InstrumentationF.h
	${GENERATED_SOURCE_DIR}/Ice/InstrumentationFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/InstrumentationFI.h
	${GENERATED_SOURCE_DIR}/Ice/InstrumentationI.cpp
	${GENERATED_SOURCE_DIR}/Ice/InstrumentationI.h
	${GENERATED_SOURCE_DIR}/Ice/LocalException.cpp
	${GENERATED_SOURCE_DIR}/Ice/LocalException.h
	${GENERATED_SOURCE_DIR}/Ice/LocalExceptionI.cpp
	${GENERATED_SOURCE_DIR}/Ice/LocalExceptionI.h
	${GENERATED_SOURCE_DIR}/Ice/Locator.cpp
	${GENERATED_SOURCE_DIR}/Ice/Locator.h
	${GENERATED_SOURCE_DIR}/Ice/LocatorF.cpp
	${GENERATED_SOURCE_DIR}/Ice/LocatorF.h
	${GENERATED_SOURCE_DIR}/Ice/LocatorFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/LocatorFI.h
	${GENERATED_SOURCE_DIR}/Ice/LocatorI.cpp
	${GENERATED_SOURCE_DIR}/Ice/LocatorI.h
	${GENERATED_SOURCE_DIR}/Ice/Logger.cpp
	${GENERATED_SOURCE_DIR}/Ice/Logger.h
	${GENERATED_SOURCE_DIR}/Ice/LoggerF.cpp
	${GENERATED_SOURCE_DIR}/Ice/LoggerF.h
	${GENERATED_SOURCE_DIR}/Ice/LoggerFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/LoggerFI.h
	${GENERATED_SOURCE_DIR}/Ice/LoggerI.cpp
	${GENERATED_SOURCE_DIR}/Ice/LoggerI.h
	${GENERATED_SOURCE_DIR}/Ice/Metrics.cpp
	${GENERATED_SOURCE_DIR}/Ice/Metrics.h
	${GENERATED_SOURCE_DIR}/Ice/MetricsI.cpp
	${GENERATED_SOURCE_DIR}/Ice/MetricsI.h
	${GENERATED_SOURCE_DIR}/Ice/ObjectAdapter.cpp
	${GENERATED_SOURCE_DIR}/Ice/ObjectAdapter.h
	${GENERATED_SOURCE_DIR}/Ice/ObjectAdapterF.cpp
	${GENERATED_SOURCE_DIR}/Ice/ObjectAdapterF.h
	${GENERATED_SOURCE_DIR}/Ice/ObjectAdapterFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ObjectAdapterFI.h
	${GENERATED_SOURCE_DIR}/Ice/ObjectAdapterI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ObjectAdapterI.h
	${GENERATED_SOURCE_DIR}/Ice/ObjectFactory.cpp
	${GENERATED_SOURCE_DIR}/Ice/ObjectFactory.h
	${GENERATED_SOURCE_DIR}/Ice/ObjectFactoryI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ObjectFactoryI.h
	${GENERATED_SOURCE_DIR}/Ice/Plugin.cpp
	${GENERATED_SOURCE_DIR}/Ice/Plugin.h
	${GENERATED_SOURCE_DIR}/Ice/PluginF.cpp
	${GENERATED_SOURCE_DIR}/Ice/PluginF.h
	${GENERATED_SOURCE_DIR}/Ice/PluginFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/PluginFI.h
	${GENERATED_SOURCE_DIR}/Ice/PluginI.cpp
	${GENERATED_SOURCE_DIR}/Ice/PluginI.h
	${GENERATED_SOURCE_DIR}/Ice/Process.cpp
	${GENERATED_SOURCE_DIR}/Ice/Process.h
	${GENERATED_SOURCE_DIR}/Ice/ProcessF.cpp
	${GENERATED_SOURCE_DIR}/Ice/ProcessF.h
	${GENERATED_SOURCE_DIR}/Ice/ProcessFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ProcessFI.h
	${GENERATED_SOURCE_DIR}/Ice/ProcessI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ProcessI.h
	${GENERATED_SOURCE_DIR}/Ice/Properties.cpp
	${GENERATED_SOURCE_DIR}/Ice/Properties.h
	${GENERATED_SOURCE_DIR}/Ice/PropertiesAdmin.cpp
	${GENERATED_SOURCE_DIR}/Ice/PropertiesAdmin.h
	${GENERATED_SOURCE_DIR}/Ice/PropertiesAdminI.cpp
	${GENERATED_SOURCE_DIR}/Ice/PropertiesAdminI.h
	${GENERATED_SOURCE_DIR}/Ice/PropertiesF.cpp
	${GENERATED_SOURCE_DIR}/Ice/PropertiesF.h
	${GENERATED_SOURCE_DIR}/Ice/PropertiesFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/PropertiesFI.h
	${GENERATED_SOURCE_DIR}/Ice/PropertiesI.cpp
	${GENERATED_SOURCE_DIR}/Ice/PropertiesI.h
	${GENERATED_SOURCE_DIR}/Ice/RemoteLogger.cpp
	${GENERATED_SOURCE_DIR}/Ice/RemoteLogger.h
	${GENERATED_SOURCE_DIR}/Ice/RemoteLoggerI.cpp
	${GENERATED_SOURCE_DIR}/Ice/RemoteLoggerI.h
	${GENERATED_SOURCE_DIR}/Ice/Router.cpp
	${GENERATED_SOURCE_DIR}/Ice/Router.h
	${GENERATED_SOURCE_DIR}/Ice/RouterF.cpp
	${GENERATED_SOURCE_DIR}/Ice/RouterF.h
	${GENERATED_SOURCE_DIR}/Ice/RouterFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/RouterFI.h
	${GENERATED_SOURCE_DIR}/Ice/RouterI.cpp
	${GENERATED_SOURCE_DIR}/Ice/RouterI.h
	${GENERATED_SOURCE_DIR}/Ice/ServantLocator.cpp
	${GENERATED_SOURCE_DIR}/Ice/ServantLocator.h
	${GENERATED_SOURCE_DIR}/Ice/ServantLocatorF.cpp
	${GENERATED_SOURCE_DIR}/Ice/ServantLocatorF.h
	${GENERATED_SOURCE_DIR}/Ice/ServantLocatorFI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ServantLocatorFI.h
	${GENERATED_SOURCE_DIR}/Ice/ServantLocatorI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ServantLocatorI.h
	${GENERATED_SOURCE_DIR}/Ice/SliceChecksumDict.cpp
	${GENERATED_SOURCE_DIR}/Ice/SliceChecksumDict.h
	${GENERATED_SOURCE_DIR}/Ice/SliceChecksumDictI.cpp
	${GENERATED_SOURCE_DIR}/Ice/SliceChecksumDictI.h
	${GENERATED_SOURCE_DIR}/Ice/ValueFactory.cpp
	${GENERATED_SOURCE_DIR}/Ice/ValueFactory.h
	${GENERATED_SOURCE_DIR}/Ice/ValueFactoryI.cpp
	${GENERATED_SOURCE_DIR}/Ice/ValueFactoryI.h
	${GENERATED_SOURCE_DIR}/Ice/Version.cpp
	${GENERATED_SOURCE_DIR}/Ice/Version.h
	${GENERATED_SOURCE_DIR}/Ice/VersionI.cpp
	${GENERATED_SOURCE_DIR}/Ice/VersionI.h
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

target_sources(ice
   PRIVATE
	   Acceptor.cpp
	   ACM.cpp
	   Application.cpp
	   ArgVector.cpp
	   AsyncResult.cpp
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
	   DLLMain.cpp
	   DynamicLibrary.cpp
	   EndpointFactory.cpp
		EndpointFactory.h
		EventLoggerMsg.mc
		${CMAKE_CURRENT_BINARY_DIR}/EventLoggerMsg.rc
	   EventHandler.cpp
	   Exception.cpp
	   FactoryTable.cpp
	   FactoryTableInit.cpp
	   GCObject.cpp
	   HttpParser.cpp
	   Ice.rc
	   IconvStringConverter.cpp
	   ImplicitContextI.cpp
	   Incoming.cpp
	   IncomingAsync.cpp
	   Initialize.cpp
	   InputStream.cpp
	   Instance.cpp
	   InstrumentationI.cpp
	   InstrumentationI.h
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
	   ReplyStatus.h
	   RequestHandler.cpp
	   RequestHandlerFactory.cpp
	   ResponseHandler.cpp
	   RetryQueue.cpp
	   RouterInfo.cpp
	   Selector.cpp
	   Selector.h
	   ServantManager.cpp
	   Service.cpp
	   SHA1.cpp
	   SliceChecksums.cpp
	   SlicedData.cpp
	   StreamSocket.cpp
	   StringConverterPlugin.cpp
	   SysLoggerI.cpp
	   SystemdJournalI.cpp
	   TcpAcceptor.cpp
	   TcpConnector.cpp
	   TcpEndpointI.cpp
	   TcpTransceiver.cpp
	   Thread.cpp
	   ThreadPool.cpp
	   Timer.cpp
	   TraceLevels.cpp
	   TraceUtil.cpp
	   Transceiver.cpp
	   UdpConnector.cpp
	   UdpEndpointI.cpp
	   UdpTransceiver.cpp
	   Value.cpp
	   ValueFactoryManagerI.cpp
	   WSAcceptor.cpp
	   WSConnector.cpp
	   WSEndpoint.cpp
	   WSTransceiver.cpp
		${GENERATED_ICE_SOURCES}
		${ICE_SLICES}
)

set_source_files_properties(${CMAKE_CURRENT_BINARY_DIR}/EventLoggerMsg.rc PROPERTIES GENERATED TRUE)

find_package(BZip2 REQUIRED)
add_dependencies(ice slice2cpp)

# deal with Win32 path too long

if(WIN32)
	target_include_directories(ice 
		PRIVATE 
			"\\?\${CMAKE_SOURCE_DIR}/cpp/include"
			"\\?\${CMAKE_SOURCE_DIR}/cpp/src"
			"\\?\${CMAKE_CURRENT_BINARY_DIR}/generated"
			"\\?\${GENERATED_SOURCE_DIR}"
			"\\?\${BZIP2_INCLUDE_DIR}"
	)
else
	target_include_directories(ice 
		PRIVATE 
			${CMAKE_SOURCE_DIR}/cpp/include
			${CMAKE_SOURCE_DIR}/cpp/src
			${CMAKE_CURRENT_BINARY_DIR}/generated
			${GENERATED_SOURCE_DIR}
			${BZIP2_INCLUDE_DIR}
	)
endif()

if(CMAKE_CXX_STANDARD EQUAL 11)
	set(ICELIB_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}")
	#set(CMAKE_RC_FLAGS ${ICE_RC_FLAGS})
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

	target_compile_options(ice PRIVATE 
		"/wd4996" 
		${ICE_COMPILE_OPTIONS} 
	)

	target_compile_definitions(ice PRIVATE 
		${ICELIB_COMPILE_DEFS}
		"ICE_API_EXPORTS"
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
	
	add_custom_command(TARGET ice
		COMMAND ${CMAKE_MC_COMPILER} ${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
		WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
		PRE_BUILD
		DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
	)
endif()

foreach(slice ${ICE_SLICES})
#function(CompileSlices slice2_bin slice_path ice_file slice_target output_dir)
	CompileSlices(slice2cpp
		${SLICE_DIR}
		${slice}
		ice
		${GENERATED_SOURCE_DIR}/Ice
	)
endforeach()

install(TARGETS ice DESTINATION lib)
