if(CMAKE_CXX_STANDARD EQUAL 11)
	set(ICE_PROJECT_NAME ice++11)
elseif(CMAKE_CXX_STANDARD EQUAL 98)
	set(ICE_PROJECT_NAME ice)
endif()

add_library(${ICE_PROJECT_NAME})

if(NOT ${PROJECT_BINARY_DIR}/generated/Ice)
	file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated/Ice)
endif()

set(GENERATED_ICE_SOURCES_DIR ${PROJECT_BINARY_DIR}/generated/Ice)

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

if(WIN32)
	set(GENERATED_ICE_RESOURCES
		${GENERATED_ICE_SOURCES_DIR}/EventLoggerMsg.h
		${GENERATED_ICE_SOURCES_DIR}/EventLoggerMsg.rc
	)

	set_source_files_properties(${GENERATED_ICE_RESOURCES} PROPERTIES GENERATED TRUE)
endif()

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
		EndpointFactoryManager.cpp
		EndpointI.cpp
		EventHandler.cpp
		EventLoggerMsg.mc
		Exception.cpp
		FactoryTable.cpp
		FactoryTableInit.cpp
		GCObject.cpp
		HttpParser.cpp
		IconvStringConverter.cpp
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
		ResponseHandler.cpp
		RetryQueue.cpp
		RouterInfo.cpp
		Selector.cpp
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
		${GENERATED_ICE_HEADERS}
		${ICE_SLICES}
)

if(WIN32)
	target_sources(${ICE_PROJECT_NAME}
		PRIVATE
		${GENERATED_ICE_RESOURCES}
	)
endif()

find_package(BZip2 REQUIRED)
add_dependencies(${ICE_PROJECT_NAME} slice2cpp)

target_include_directories(${ICE_PROJECT_NAME}
	PRIVATE 
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${PROJECT_BINARY_DIR}/generated
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

	target_compile_options(${ICE_PROJECT_NAME} 
		PRIVATE 
			"/wd4996" 
			${ICE_COMPILE_OPTIONS} 
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

	add_custom_command(TARGET ${ICE_PROJECT_NAME}
		COMMAND ${CMAKE_MC_COMPILER} ${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
		WORKING_DIRECTORY ${GENERATED_ICE_SOURCES_DIR}
		PRE_BUILD
		DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/EventLoggerMsg.mc
	)
endif()

target_compile_definitions(${ICE_PROJECT_NAME} 
	PRIVATE 
		${ICELIB_COMPILE_DEFS}
		"ICE_API_EXPORTS"
)

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
