if(NOT ${GENERATED_SLICES_DIR}/Ice)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/Ice)
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

if(MSVC)
	set(GENERATED_ICE_RESOURCES
		${GENERATED_SLICES_DIR}/Ice/EventLoggerMsg.h
		${GENERATED_SLICES_DIR}/Ice/EventLoggerMsg.rc
	)
endif()

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
	${ICE_SLICES}
)

if(NOT WINDOWS_STORE)
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
		DESTINATION include
		FILES_MATCHING PATTERN "*.h"
	)
	
	add_library(ice)

	set_property(TARGET ice PROPERTY CXX_STANDARD 98)

	target_sources(ice 
		PRIVATE 
			${ICE_SOURCES}
			${GENERATED_ICE_SOURCES}
			${GENERATED_ICE_HEADERS}
			$<TARGET_OBJECTS:iceutil>
	)

	if(LINUX)
		target_sources(ice
			PRIVATE
				SystemdJournalI.cpp
				SystemdJournalI.h
		)
	endif()

	target_include_directories(ice
		PRIVATE 
			${GENERATED_SLICES_DIR}
			${PROJECT_SOURCE_DIR}/cpp/include
			${PROJECT_SOURCE_DIR}/cpp/src
			${BZIP2_INCLUDE_DIR}
	)

	target_link_libraries(ice
		PRIVATE
			BZip2::BZip2
	)

	target_compile_definitions(ice 
		PRIVATE 
			${ICE_COMPILE_DEFS}
			"ICE_API_EXPORTS"
	)

	if(MSVC)
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
				${GENERATED_SLICES_DIR}/Ice/EventLoggerMsg.h
		)

		target_compile_options(ice 
			PRIVATE 
				"/wd4996" 
				${ICE_MSVC_COMPILE_OPTIONS} 
		)

		target_link_libraries(ice
			PRIVATE
				advapi32.lib
				ws2_32.lib
				Iphlpapi.lib
				rpcrt4.lib
				DbgHelp.lib
				Shlwapi.lib
		)

		target_sources(ice
			PRIVATE
				EventLoggerMsg.mc
				Ice.rc
				${GENERATED_ICE_RESOURCES}
		)

		target_compile_definitions(ice
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
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

	set_target_properties(ice 
		PROPERTIES
			OUTPUT_NAME Ice${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
			LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS}
	)

	install(TARGETS ice DESTINATION lib)

	add_library(ice++11)

	set_property(TARGET ice++11 PROPERTY CXX_STANDARD 11)

	target_sources(ice++11 
		PRIVATE 
			${ICE_SOURCES}
			${GENERATED_ICE_SOURCES}
			${GENERATED_ICE_HEADERS}
	)

	if(LINUX)
		target_sources(ice++11
			PRIVATE
				SystemdJournalI.cpp
				SystemdJournalI.h
		)
	endif()

	target_include_directories(ice++11
		PRIVATE 
			${GENERATED_SLICES_DIR}
			${PROJECT_SOURCE_DIR}/cpp/include
			${PROJECT_SOURCE_DIR}/cpp/src
			${BZIP2_INCLUDE_DIR}
	)

	target_link_libraries(ice++11
		PRIVATE
			iceutil++11
			BZip2::BZip2
	)

	target_compile_definitions(ice++11 
		PRIVATE 
			${ICE_CPP11_COMPILE_DEFS}
			"ICE_API_EXPORTS"
	)

	if(MSVC)
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
				${GENERATED_SLICES_DIR}/Ice/EventLoggerMsg.h
		)

		target_compile_options(ice++11 
			PRIVATE 
				"/wd4996" 
				${ICE_MSVC_COMPILE_OPTIONS} 
		)

		target_link_libraries(ice++11
			PRIVATE
				advapi32.lib
				ws2_32.lib
				Iphlpapi.lib
				rpcrt4.lib
				DbgHelp.lib
				Shlwapi.lib
		)

		target_sources(ice++11
			PRIVATE
				EventLoggerMsg.mc
				Ice.rc
				${GENERATED_ICE_RESOURCES}
		)

		target_compile_definitions(ice++11
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
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

	set_target_properties(ice++11 
		PROPERTIES
			OUTPUT_NAME Ice${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}++11
			LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS}
	)

	install(TARGETS ice++11 DESTINATION lib)
endif()
