if(NOT ${GENERATED_SLICES_DIR}/IceStorm)
	file(MAKE_DIRECTORY ${GENERATED_SLICES_DIR}/IceStorm)
endif()

set(ICESTORMSERVICE_SLICES
	${CMAKE_CURRENT_SOURCE_DIR}/Election.ice
	${CMAKE_CURRENT_SOURCE_DIR}/IceStormInternal.ice
	${CMAKE_CURRENT_SOURCE_DIR}/Instrumentation.ice
	${CMAKE_CURRENT_SOURCE_DIR}/LinkRecord.ice
	${CMAKE_CURRENT_SOURCE_DIR}/LLURecord.ice
	${CMAKE_CURRENT_SOURCE_DIR}/SubscriberRecord.ice
)

set(GENERATED_ICESTORMSERVICE_HEADERS
	${GENERATED_SLICES_DIR}/IceStorm/Election.h
	${GENERATED_SLICES_DIR}/IceStorm/IceStormInternal.h
	${GENERATED_SLICES_DIR}/IceStorm/Instrumentation.h
	${GENERATED_SLICES_DIR}/IceStorm/LinkRecord.h
	${GENERATED_SLICES_DIR}/IceStorm/LLURecord.h
	${GENERATED_SLICES_DIR}/IceStorm/SubscriberRecord.h
)

set(GENERATED_ICESTORMSERVICE_SOURCES
	${GENERATED_SLICES_DIR}/IceStorm/Election.cpp
	${GENERATED_SLICES_DIR}/IceStorm/IceStormInternal.cpp
	${GENERATED_SLICES_DIR}/IceStorm/Instrumentation.cpp
	${GENERATED_SLICES_DIR}/IceStorm/LinkRecord.cpp
	${GENERATED_SLICES_DIR}/IceStorm/LLURecord.cpp
	${GENERATED_SLICES_DIR}/IceStorm/SubscriberRecord.cpp
)

add_library(icestormservice)

target_sources(icestormservice
	PRIVATE
		Instance.cpp
		Instance.h
		InstrumentationI.cpp
		InstrumentationI.h
		NodeI.cpp
		NodeI.h
		Observers.cpp
		Observers.h
		Replica.h
		Service.cpp
		Service.h
		Subscriber.cpp
		Subscriber.h
		TopicI.cpp
		TopicI.h
		TopicManagerI.cpp
		TopicManagerI.h
		TraceLevels.cpp
		TraceLevels.h
		TransientTopicI.cpp
		TransientTopicI.h
		TransientTopicManagerI.cpp
		TransientTopicManagerI.h
		Util.cpp
		Util.h
		${GENERATED_ICESTORMSERVICE_HEADERS}
		${GENERATED_ICESTORMSERVICE_SOURCES}
		${ICESTORMSERVICE_SLICES}
)

target_include_directories(icestormservice
	PRIVATE 
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${LMDB_INCLUDE_DIR}
)

target_compile_definitions(icestormservice
	PRIVATE
		${ICE_COMPILE_DEFS}
)

target_link_libraries(icestormservice
	PRIVATE
		glacier2
		iceboxlib
		icedb
		icegrid
		icestorm
	)

if(WIN32)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceStormService.rc
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceStorm
		PREFIX "Header Files/Generated"
		FILES
			${GENERATED_ICESTORMSERVICE_HEADERS}
	)

	source_group(
		TREE ${GENERATED_SLICES_DIR}/IceStorm
		PREFIX "Source Files/Generated"
		FILES
			${GENERATED_ICESTORMSERVICE_SOURCES}
	)

	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Slice Files"
		FILES
			${ICESTORMSERVICE_SLICES}
	)

	target_sources(icestormservice
		PRIVATE
			IceStormService.rc
	)

	target_compile_options(icestormservice
		PRIVATE
			${ICE_WIN32_COMPILE_OPTIONS}   
	)

	target_compile_definitions(icestormservice
		PRIVATE
			${ICE_WIN32_COMPILE_DEFS}
	)
endif()

list(APPEND ICESTORMSERVICE_SLICE_DIRS "-I${SLICE_DIR}" "-I${PROJECT_SOURCE_DIR}/cpp/src")
list(APPEND ICESTORMSERVICE_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "IceStorm")

foreach(slice ${ICESTORMSERVICE_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${GENERATED_SLICES_DIR}/IceStorm/${slice_name}.cpp
		${GENERATED_SLICES_DIR}/IceStorm/${slice_name}.h
	)
	#function(CompileSlice slice2_bin slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice(slice2cpp
		"${ICESTORMSERVICE_SLICE_PARAMS}"
		"${ICESTORMSERVICE_SLICE_DIRS}"
		${slice}
		${GENERATED_SLICES_DIR}/IceStorm
		"${output_files}"
	)
endforeach()

set_target_properties(icestormservice
	PROPERTIES
		OUTPUT_NAME IceStormService
)

install(DIRECTORY ${GENERATED_SLICES_DIR}/IceStorm 
	DESTINATION include
	FILES_MATCHING PATTERN "*.h"
)
install(TARGETS icestormservice DESTINATION lib)
