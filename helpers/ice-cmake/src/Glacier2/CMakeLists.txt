
project(Glacier2)

add_library(glacier2)

target_sources(glacier2
   PRIVATE
      Blobject.cpp
	  Blobject.h
	  ClientBlobject.cpp
	  ClientBlobject.h
	  FilterI.cpp
	  FilterI.h
	  FilterManager.cpp
	  FilterManager.h
	  Glacier2Router.cpp
	  Glacier2Router.rc
	  Instance.cpp
	  Instance.h
	  Instrumentation.ice
	  InstrumentationI.cpp
	  InstrumentationI.h
	  ProxyVerifier.cpp
	  ProxyVerifier.h
	  RequestQueue.cpp
	  RequestQueue.h
	  RouterI.cpp
	  RouterI.h
	  RoutingTable.cpp
	  RoutingTable.h
	  ServerBlobject.cpp
	  ServerBlobject.h
	  SessionRouterI.cpp
	  SessionRouterI.h
)

target_include_directories(glacier2
   PRIVATE 
      #"${CMAKE_SOURCE_DIR}/include"
	  "${CMAKE_SOURCE_DIR}/include/generated"
	  "${CMAKE_SOURCE_DIR}/src"
)

target_compile_definitions(ice PRIVATE "GLACIER2_API_EXPORTS")

add_dependencies(glacier2 ice)

target_link_libraries(glacier2 PRIVATE ice)
