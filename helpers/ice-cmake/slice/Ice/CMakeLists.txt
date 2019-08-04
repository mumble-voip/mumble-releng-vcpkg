add_library(ice-slices OBJECT)

set(SLICES 
   BuiltinSequences.ice
   Communicator.ice
   CommunicatorF.ice
   Connection.ice
   ConnectionF.ice
   Current.ice
   Endpoint.ice
   EndpointF.ice
   EndpointTypes.ice
   FacetMap.ice
   Identity.ice
   ImplicitContext.ice
   ImplicitContextF.ice
   Instrumentation.ice
   InstrumentationF.ice
   LocalException.ice
   Locator.ice
   LocatorF.ice
   Logger.ice
   LoggerF.ice
   Metrics.ice
   ObjectAdapter.ice
   ObjectAdapterF.ice
   ObjectFactory.ice
   Plugin.ice
   PluginF.ice
   Process.ice
   ProcessF.ice
   Properties.ice
   PropertiesAdmin.ice
   PropertiesF.ice
   RemoteLogger.ice
   Router.ice
   RouterF.ice
   ServantLocator.ice
   ServantLocatorF.ice
   SliceChecksumDict.ice
   ValueFactory.ice
   Version.ice
)

target_sources(ice-slices 
   PRIVATE
   
)


if($<COMPILE_LANGUAGE:CXX>)
   add_dependencies(ice-slices slice2cpp)
   set(slice2lang_bin slice2cpp)
endif()

foreach(slice ${SLICES})
   add_custom_command(TARGET ice-slices
      COMMAND ${slice2_bin} -I${slice_path} ${ice_file} ${lang_std}
      WORKING_DIRECTORY ${output_dir}
      PRE_BUILD
      DEPENDS ${slice2lang_bin} ${slice}
      )
endforeach()

target_include_directories(ice-slices
   PRIVATE

)
