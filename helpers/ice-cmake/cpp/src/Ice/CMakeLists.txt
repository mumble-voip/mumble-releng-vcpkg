include("${CMAKE_SOURCE_DIR}/cmake/CompileSlices.cmake")
file(GLOB ICE_SLICES "${SLICES_DIR}/Ice" *.ice)

file(MAKE_DIRECTORY "${PROJECT_BINARY_DIR}/include/generated/Ice")
set(SLICE_GENERATED_SOURCE_DIR "${PROJECT_BINARY_DIR}/include/generated/Ice")
set(SLICE_BIN "${PROJECT_BINARY_DIR}/cpp/src/slice2cpp/Debug/slice2cpp.exe")

foreach(item ${ICE_SLICES})
   get_filename_component(item_FILE_NAME ${item} NAME_WE)
      list(APPEND ICE_GENERATED_FILES 
	     "${item_FILE_NAME}.cpp" 
		 "${item_FILE_NAME}.h"
	  )
   #function(CompileSlices slice_bin slice_path ice_file output_dir gen_file_type)
   CompileSlices(${SLICE_BIN} "${SLICES_DIR}/Ice" ${item} 
      ${SLICE_GENERATED_SOURCE_DIR} ${ICE_GENERATED_FILES})
endforeach()

add_library(ice)
target_sources(ice
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
	   ${SLICE_GENERATED_SOURCE_DIR}
)

target_include_directories(ice 
   PRIVATE 
      "${CMAKE_SOURCE_DIR}/cpp/include"
	  "${CMAKE_SOURCE_DIR}/cpp/src"
	  "${PROJECT_BINARY_DIR}/include/generated"
)

target_compile_definitions(ice PRIVATE "ICE_API_EXPORTS")

add_dependencies(ice slice2cpp)
add_custom_command(
   OUTPUT ${CMAKE_CURRENT_BINARY_DIR}
   COMMAND ${CMAKE_MC_COMPILER}
   ARGS "-r EventLoggerMsg.mc"
   WORKING_DIRECTORY ${Ice_BINARY_DIR}
)

if(WIN32)
   if(MSVC)
      target_compile_options(ice PRIVATE "/wd4996")
   endif()
   
   target_link_libraries(ice
      PRIVATE
	     "advapi32.lib"
		 "ws2_32.lib"
		 "Iphlpapi.lib"
		 "rpcrt4.lib"
		 "DbgHelp.lib"
		 "Shlwapi.lib"
   )
endif()
