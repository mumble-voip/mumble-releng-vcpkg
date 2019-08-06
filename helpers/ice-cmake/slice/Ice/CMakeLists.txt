add_library(ice-slices)

set(SLICES 
   ${CMAKE_CURRENT_SOURCE_DIR}/BuiltinSequences.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Communicator.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/CommunicatorF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Connection.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/ConnectionF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Current.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Endpoint.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/EndpointF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/EndpointTypes.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/FacetMap.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Identity.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/ImplicitContext.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/ImplicitContextF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Instrumentation.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/InstrumentationF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/LocalException.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Locator.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/LocatorF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Logger.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/LoggerF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Metrics.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/ObjectAdapter.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/ObjectAdapterF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/ObjectFactory.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Plugin.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/PluginF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Process.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/ProcessF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Properties.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/PropertiesAdmin.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/PropertiesF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/RemoteLogger.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Router.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/RouterF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/ServantLocator.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/ServantLocatorF.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/SliceChecksumDict.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/ValueFactory.ice
   ${CMAKE_CURRENT_SOURCE_DIR}/Version.ice
)

if(NOT ${CMAKE_CURRENT_BINARY_DIR}/include/generated/Ice)
   file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/include/generated/Ice)
endif()

set(GENERATED_SOURCES_DIR ${CMAKE_CURRENT_BINARY_DIR}/include/generated/Ice)

set(GENERATED_SOURCES
   ${GENERATED_SOURCES_DIR}/BuiltinSequences.cpp
   ${GENERATED_SOURCES_DIR}/BuiltinSequences.h
   ${GENERATED_SOURCES_DIR}/BuiltinSequencesI.cpp
   ${GENERATED_SOURCES_DIR}/BuiltinSequencesI.h
   ${GENERATED_SOURCES_DIR}/Communicator.cpp
   ${GENERATED_SOURCES_DIR}/Communicator.h
   ${GENERATED_SOURCES_DIR}/CommunicatorF.cpp
   ${GENERATED_SOURCES_DIR}/CommunicatorF.h
   ${GENERATED_SOURCES_DIR}/CommunicatorFI.cpp
   ${GENERATED_SOURCES_DIR}/CommunicatorFI.h
   ${GENERATED_SOURCES_DIR}/CommunicatorI.cpp
   ${GENERATED_SOURCES_DIR}/CommunicatorI.h
   ${GENERATED_SOURCES_DIR}/Connection.cpp
   ${GENERATED_SOURCES_DIR}/Connection.h
   ${GENERATED_SOURCES_DIR}/ConnectionF.cpp
   ${GENERATED_SOURCES_DIR}/ConnectionF.h
   ${GENERATED_SOURCES_DIR}/ConnectionFI.cpp
   ${GENERATED_SOURCES_DIR}/ConnectionFI.h
   ${GENERATED_SOURCES_DIR}/ConnectionI.cpp
   ${GENERATED_SOURCES_DIR}/ConnectionI.h
   ${GENERATED_SOURCES_DIR}/Current.cpp
   ${GENERATED_SOURCES_DIR}/Current.h
   ${GENERATED_SOURCES_DIR}/CurrentI.cpp
   ${GENERATED_SOURCES_DIR}/CurrentI.h
   ${GENERATED_SOURCES_DIR}/Endpoint.cpp
   ${GENERATED_SOURCES_DIR}/Endpoint.h
   ${GENERATED_SOURCES_DIR}/EndpointF.cpp
   ${GENERATED_SOURCES_DIR}/EndpointF.h
   ${GENERATED_SOURCES_DIR}/EndpointFI.cpp
   ${GENERATED_SOURCES_DIR}/EndpointFI.h
   ${GENERATED_SOURCES_DIR}/EndpointI.cpp
   ${GENERATED_SOURCES_DIR}/EndpointI.h
   ${GENERATED_SOURCES_DIR}/EndpointTypes.cpp
   ${GENERATED_SOURCES_DIR}/EndpointTypes.h
   ${GENERATED_SOURCES_DIR}/EndpointTypesI.cpp
   ${GENERATED_SOURCES_DIR}/EndpointTypesI.h
   ${GENERATED_SOURCES_DIR}/FacetMap.cpp
   ${GENERATED_SOURCES_DIR}/FacetMap.h
   ${GENERATED_SOURCES_DIR}/FacetMapI.cpp
   ${GENERATED_SOURCES_DIR}/FacetMapI.h
   ${GENERATED_SOURCES_DIR}/Identity.cpp
   ${GENERATED_SOURCES_DIR}/Identity.h
   ${GENERATED_SOURCES_DIR}/IdentityI.cpp
   ${GENERATED_SOURCES_DIR}/IdentityI.h
   ${GENERATED_SOURCES_DIR}/ImplicitContext.cpp
   ${GENERATED_SOURCES_DIR}/ImplicitContext.h
   ${GENERATED_SOURCES_DIR}/ImplicitContextF.cpp
   ${GENERATED_SOURCES_DIR}/ImplicitContextF.h
   ${GENERATED_SOURCES_DIR}/ImplicitContextFI.cpp
   ${GENERATED_SOURCES_DIR}/ImplicitContextFI.h
   ${GENERATED_SOURCES_DIR}/ImplicitContextI.cpp
   ${GENERATED_SOURCES_DIR}/ImplicitContextI.h
   ${GENERATED_SOURCES_DIR}/Instrumentation.cpp
   ${GENERATED_SOURCES_DIR}/Instrumentation.h
   ${GENERATED_SOURCES_DIR}/InstrumentationF.cpp
   ${GENERATED_SOURCES_DIR}/InstrumentationF.h
   ${GENERATED_SOURCES_DIR}/InstrumentationFI.cpp
   ${GENERATED_SOURCES_DIR}/InstrumentationFI.h
   ${GENERATED_SOURCES_DIR}/InstrumentationI.cpp
   ${GENERATED_SOURCES_DIR}/InstrumentationI.h
   ${GENERATED_SOURCES_DIR}/LocalException.cpp
   ${GENERATED_SOURCES_DIR}/LocalException.h
   ${GENERATED_SOURCES_DIR}/LocalExceptionI.cpp
   ${GENERATED_SOURCES_DIR}/LocalExceptionI.h
   ${GENERATED_SOURCES_DIR}/Locator.cpp
   ${GENERATED_SOURCES_DIR}/Locator.h
   ${GENERATED_SOURCES_DIR}/LocatorF.cpp
   ${GENERATED_SOURCES_DIR}/LocatorF.h
   ${GENERATED_SOURCES_DIR}/LocatorFI.cpp
   ${GENERATED_SOURCES_DIR}/LocatorFI.h
   ${GENERATED_SOURCES_DIR}/LocatorI.cpp
   ${GENERATED_SOURCES_DIR}/LocatorI.h
   ${GENERATED_SOURCES_DIR}/Logger.cpp
   ${GENERATED_SOURCES_DIR}/Logger.h
   ${GENERATED_SOURCES_DIR}/LoggerF.cpp
   ${GENERATED_SOURCES_DIR}/LoggerF.h
   ${GENERATED_SOURCES_DIR}/LoggerFI.cpp
   ${GENERATED_SOURCES_DIR}/LoggerFI.h
   ${GENERATED_SOURCES_DIR}/LoggerI.cpp
   ${GENERATED_SOURCES_DIR}/LoggerI.h
   ${GENERATED_SOURCES_DIR}/Metrics.cpp
   ${GENERATED_SOURCES_DIR}/Metrics.h
   ${GENERATED_SOURCES_DIR}/MetricsI.cpp
   ${GENERATED_SOURCES_DIR}/MetricsI.h
   ${GENERATED_SOURCES_DIR}/ObjectAdapter.cpp
   ${GENERATED_SOURCES_DIR}/ObjectAdapter.h
   ${GENERATED_SOURCES_DIR}/ObjectAdapterF.cpp
   ${GENERATED_SOURCES_DIR}/ObjectAdapterF.h
   ${GENERATED_SOURCES_DIR}/ObjectAdapterFI.cpp
   ${GENERATED_SOURCES_DIR}/ObjectAdapterFI.h
   ${GENERATED_SOURCES_DIR}/ObjectAdapterI.cpp
   ${GENERATED_SOURCES_DIR}/ObjectAdapterI.h
   ${GENERATED_SOURCES_DIR}/ObjectFactory.cpp
   ${GENERATED_SOURCES_DIR}/ObjectFactory.h
   ${GENERATED_SOURCES_DIR}/ObjectFactoryI.cpp
   ${GENERATED_SOURCES_DIR}/ObjectFactoryI.h
   ${GENERATED_SOURCES_DIR}/Plugin.cpp
   ${GENERATED_SOURCES_DIR}/Plugin.h
   ${GENERATED_SOURCES_DIR}/PluginF.cpp
   ${GENERATED_SOURCES_DIR}/PluginF.h
   ${GENERATED_SOURCES_DIR}/PluginFI.cpp
   ${GENERATED_SOURCES_DIR}/PluginFI.h
   ${GENERATED_SOURCES_DIR}/PluginI.cpp
   ${GENERATED_SOURCES_DIR}/PluginI.h
   ${GENERATED_SOURCES_DIR}/Process.cpp
   ${GENERATED_SOURCES_DIR}/Process.h
   ${GENERATED_SOURCES_DIR}/ProcessF.cpp
   ${GENERATED_SOURCES_DIR}/ProcessF.h
   ${GENERATED_SOURCES_DIR}/ProcessFI.cpp
   ${GENERATED_SOURCES_DIR}/ProcessFI.h
   ${GENERATED_SOURCES_DIR}/ProcessI.cpp
   ${GENERATED_SOURCES_DIR}/ProcessI.h
   ${GENERATED_SOURCES_DIR}/Properties.cpp
   ${GENERATED_SOURCES_DIR}/Properties.h
   ${GENERATED_SOURCES_DIR}/PropertiesAdmin.cpp
   ${GENERATED_SOURCES_DIR}/PropertiesAdmin.h
   ${GENERATED_SOURCES_DIR}/PropertiesAdminI.cpp
   ${GENERATED_SOURCES_DIR}/PropertiesAdminI.h
   ${GENERATED_SOURCES_DIR}/PropertiesF.cpp
   ${GENERATED_SOURCES_DIR}/PropertiesF.h
   ${GENERATED_SOURCES_DIR}/PropertiesFI.cpp
   ${GENERATED_SOURCES_DIR}/PropertiesFI.h
   ${GENERATED_SOURCES_DIR}/PropertiesI.cpp
   ${GENERATED_SOURCES_DIR}/PropertiesI.h
   ${GENERATED_SOURCES_DIR}/RemoteLogger.cpp
   ${GENERATED_SOURCES_DIR}/RemoteLogger.h
   ${GENERATED_SOURCES_DIR}/RemoteLoggerI.cpp
   ${GENERATED_SOURCES_DIR}/RemoteLoggerI.h
   ${GENERATED_SOURCES_DIR}/Router.cpp
   ${GENERATED_SOURCES_DIR}/Router.h
   ${GENERATED_SOURCES_DIR}/RouterF.cpp
   ${GENERATED_SOURCES_DIR}/RouterF.h
   ${GENERATED_SOURCES_DIR}/RouterFI.cpp
   ${GENERATED_SOURCES_DIR}/RouterFI.h
   ${GENERATED_SOURCES_DIR}/RouterI.cpp
   ${GENERATED_SOURCES_DIR}/RouterI.h
   ${GENERATED_SOURCES_DIR}/ServantLocator.cpp
   ${GENERATED_SOURCES_DIR}/ServantLocator.h
   ${GENERATED_SOURCES_DIR}/ServantLocatorF.cpp
   ${GENERATED_SOURCES_DIR}/ServantLocatorF.h
   ${GENERATED_SOURCES_DIR}/ServantLocatorFI.cpp
   ${GENERATED_SOURCES_DIR}/ServantLocatorFI.h
   ${GENERATED_SOURCES_DIR}/ServantLocatorI.cpp
   ${GENERATED_SOURCES_DIR}/ServantLocatorI.h
   ${GENERATED_SOURCES_DIR}/SliceChecksumDict.cpp
   ${GENERATED_SOURCES_DIR}/SliceChecksumDict.h
   ${GENERATED_SOURCES_DIR}/SliceChecksumDictI.cpp
   ${GENERATED_SOURCES_DIR}/SliceChecksumDictI.h
   ${GENERATED_SOURCES_DIR}/ValueFactory.cpp
   ${GENERATED_SOURCES_DIR}/ValueFactory.h
   ${GENERATED_SOURCES_DIR}/ValueFactoryI.cpp
   ${GENERATED_SOURCES_DIR}/ValueFactoryI.h
   ${GENERATED_SOURCES_DIR}/Version.cpp
   ${GENERATED_SOURCES_DIR}/Version.h
   ${GENERATED_SOURCES_DIR}/VersionI.cpp
   ${GENERATED_SOURCES_DIR}/VersionI.h
)

set_source_files_properties(${GENERATED_SOURCES} PROPERTIES GENERATED TRUE)

target_sources(ice-slices 
   PRIVATE
      ${GENERATED_SOURCES}
      ${SLICES}
)

target_include_directories(ice-slices
   PRIVATE
      ${CMAKE_CURRENT_BINARY_DIR}/include/generated
      ${GENERATED_SOURCES_DIR}
      ${PROJECT_SOURCE_DIR}/cpp/include
      ${PROJECT_SOURCE_DIR}/cpp/src
)

if("${languages}" MATCHES "CXX")
   add_dependencies(ice-slices slice2cpp)
   add_executable(slice2lang_bin ALIAS slice2cpp)

   include(${PROJECT_SOURCE_DIR}/cpp/cmake/ice_cpp_props.cmake)
   if(CMAKE_CXX_STANDARD EQUAL 11)
      set(SLICE_ICE_COMPILE_DEFS "${SLICE_CPP11_COMPILE_DEFS}")
   else()
      set(SLICE_ICE_COMPILE_DEFS "${SLICE_CPP98_COMPILE_DEFS")
   endif()
   if(WIN32)
      target_compile_options(ice-slices 
      PRIVATE 
         "/wd4996" 
         ${ICE_COMPILE_OPTIONS} 
      )

      target_compile_definitions(ice-slices 
         PRIVATE 
            ${SLICE_ICE_COMPILE_DEFS}
            "ICE_API_EXPORTS"
      )
   endif()
endif()

if(WIN32)
   source_group(
      TREE ${CMAKE_CURRENT_SOURCE_DIR}
      PREFIX "Slice Files"
      FILES ${SLICES}
   )
endif()

get_property(languages GLOBAL PROPERTY ENABLED_LANGUAGES)

add_dependencies(ice-slices slice2lang_bin)

foreach(slice ${SLICES})
   add_custom_command(TARGET ice-slices
      COMMAND slice2lang_bin -I${PROJECT_SOURCE_DIR}/slice ${slice} 
      WORKING_DIRECTORY ${GENERATED_SOURCES_DIR}
      PRE_BUILD
      COMMENT "Compiling source files from ${slice}..."
      DEPENDS ${slice}
   )
endforeach()
