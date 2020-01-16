if(NOT ${GENERATED_SLICES_DIR}/IceGrid)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid)
endif()

set(ICEGRIDADMIN_SLICES
	${CMAKE_CURRENT_SOURCE_DIR}/Internal.ice
)

set(GENERATED_ICEGRIDADMIN_HEADERS
	${GENERATED_SLICES_DIR}/IceGrid/Internal.h
)

set(GENERATED_ICEGRIDADMIN_SOURCES
	${GENERATED_SLICES_DIR}/IceGrid/Internal.cpp
)

add_executable(icegridadmin)

target_sources(icegridadmin
	PRIVATE
		Client.cpp
		DescriptorBuilder.cpp
		DescriptorHelper.cpp
		DescriptorParser.cpp
		FileParserI.cpp
		Grammar.cpp
		Parser.cpp
		Scanner.cpp
		Util.cpp
		${GENERATED_ICEGRIDADMIN_HEADERS}
		${GENERATED_ICEGRIDADMIN_SOURCES}
)

target_include_directories(icegridadmin
	PRIVATE
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${EXPAT_INCLUDE_DIR}
		${BZIP2_INCLUDE_DIR}
)

target_compile_definitions(icegridadmin
	PRIVATE
		${ICE_COMPILE_DEFS}
)

target_link_libraries(icegridadmin
	PRIVATE
		icegrid
		icelocatordiscovery
		iceboxlib
		icexml
		icepatch2
		ice
		glacier2
		BZip2::BZip2
		EXPAT::EXPAT
)

if(MSVC)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceGridAdmin.rc
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceGrid
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_ICEGRIDADMIN_HEADERS}
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceGrid
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_ICEGRIDADMIN_SOURCES}
	)

	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Slice Files"
		FILES 
			Internal.ice
	)

	target_sources(icegridadmin
		PRIVATE
			IceGridAdmin.rc
	)

	target_compile_options(icegridadmin
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	target_compile_definitions(icegridadmin
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)

	target_link_options(icegridadmin
		PRIVATE
			${ICE_MSVC_LINK_OPTIONS}
	)

	target_link_libraries(icegridadmin
		PRIVATE
			advapi32.lib
			ws2_32.lib
			Iphlpapi.lib
			rpcrt4.lib
			DbgHelp.lib
			Shlwapi.lib
	)
endif()

list(APPEND ICEGRIDADMIN_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICEGRIDADMIN_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceGrid")

foreach(slice ${ICEGRIDADMIN_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files
		${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.cpp
		${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.h
	)
	#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice(slice2cpp
		"${ICEGRIDADMIN_SLICE_PARAMS}"
		"${ICEGRIDADMIN_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/IceGrid
		"${output_files}"
	)
endforeach()

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)
install(TARGETS icegridadmin DESTINATION bin)

if(NOT ${GENERATED_SLICES_DIR}/IceGrid)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid)
endif()

set(ICEGRIDNODE_SLICES
	${CMAKE_CURRENT_SOURCE_DIR}/Internal.ice
	${SLICE_DIR}/IceLocatorDiscovery/IceLocatorDiscovery.ice
)

set(GENERATED_ICEGRIDNODE_HEADERS
	${GENERATED_SLICES_DIR}/IceGrid/IceLocatorDiscovery.h
	${GENERATED_SLICES_DIR}/IceGrid/Internal.h
)

set(GENERATED_ICEGRIDNODE_SOURCES
	${GENERATED_SLICES_DIR}/IceGrid/IceLocatorDiscovery.cpp
	${GENERATED_SLICES_DIR}/IceGrid/Internal.cpp
)

add_executable(icegridnode)

target_sources(icegridnode
	PRIVATE
		Activator.cpp
		AdapterCache.cpp
		AdminCallbackRouter.cpp
		AdminI.cpp
		AdminRouter.cpp
		AdminSessionI.cpp
		Allocatable.cpp
		AllocatableObjectCache.cpp
		Database.cpp
		DescriptorBuilder.cpp
		DescriptorHelper.cpp
		DescriptorParser.cpp
		FileCache.cpp
		FileUserAccountMapperI.cpp
		IceGridNode.cpp
		InternalRegistryI.cpp
		LocatorI.cpp
		LocatorRegistryI.cpp
		NodeAdminRouter.cpp
		NodeCache.cpp
		NodeI.cpp
		NodeSessionI.cpp
		NodeSessionManager.cpp
		ObjectCache.cpp
		PlatformInfo.cpp
		PluginFacadeI.cpp
		QueryI.cpp
		ReapThread.cpp
		RegistryAdminRouter.cpp
		RegistryI.cpp
		ReplicaCache.cpp
		ReplicaSessionI.cpp
		ReplicaSessionManager.cpp
		ServerAdapterI.cpp
		ServerCache.cpp
		ServerI.cpp
		SessionI.cpp
		SessionManager.cpp
		SessionServantManager.cpp
		Topics.cpp
		TraceLevels.cpp
		Util.cpp
		WellKnownObjectsManager.cpp
		${GENERATED_ICEGRIDNODE_HEADERS}
		${GENERATED_ICEGRIDNODE_SOURCES}
		${ICEGRIDNODE_SLICES}
)

target_include_directories(icegridnode
	PRIVATE
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${BZIP2_INCLUDE_DIR}
		${EXPAT_INCLUDE_DIR}
)

target_compile_definitions(icegridnode
	PRIVATE
		${ICE_COMPILE_DEFS}
)

target_link_libraries(icegridnode
	PRIVATE
		glacier2
		ice
		iceboxlib
		icedb
		icegrid
		icepatch2
		icessl
		icestorm
		icestormservice
		icexml
		BZip2::BZip2
		EXPAT::EXPAT
)

if(MSVC)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceGridNode.rc
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_ICEGRIDNODE_HEADERS}
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_ICEGRIDNODE_SOURCES}
	)

	source_group("Slice Files"
		FILES 
			${ICEGRIDNODE_SLICES}
	)

	target_sources(icegridnode
		PRIVATE
			IceGridNode.rc
	)

	target_compile_options(icegridnode
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	target_compile_definitions(icegridnode
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)

	target_link_options(icegridnode
		PRIVATE
			${ICE_MSVC_LINK_OPTIONS}
	)

	target_link_libraries(icegridnode
		PRIVATE
			advapi32.lib
			ws2_32.lib
			Iphlpapi.lib
			rpcrt4.lib
			DbgHelp.lib
			pdh.lib
			Shlwapi.lib
			version.lib
	)
endif()

list(APPEND ICEGRIDNODE_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICEGRIDNODE_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceGrid")

foreach(slice ${ICEGRIDNODE_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.cpp
		${GENERATED_SLICES_DIR}/IceGrid/${slice_name}.h
	)
	#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice(slice2cpp
		"${ICEGRIDNODE_SLICE_PARAMS}"
		"${ICEGRIDNODE_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/IceGrid
		"${output_files}"
	)
endforeach()

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceGrid 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)
install(TARGETS icegridnode DESTINATION bin)

