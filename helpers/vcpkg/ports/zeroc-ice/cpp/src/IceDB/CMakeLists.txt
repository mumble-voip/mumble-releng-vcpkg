add_library(icedb)

target_sources(icedb
	PRIVATE
		IceDB.cpp
		IceDB.h
)

target_include_directories(icedb
	PRIVATE
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${LMDB_INCLUDE_DIR}
)

target_compile_definitions(icedb
	PRIVATE 
		${ICE_COMPILE_DEFS}
		"ICE_DB_API_EXPORTS"
)

target_link_libraries(icedb
	PRIVATE
		ice
		lmdb
)

if(WIN32)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceDB.rc
	)

	target_sources(icedb
		PRIVATE
			IceDB.rc
	)

	target_compile_options(icedb
		PRIVATE
			${ICE_WIN32_COMPILE_OPTIONS}
	)

	target_compile_definitions(icedb
		PRIVATE
			${ICE_WIN32_COMPILE_DEFS}
	)
endif()

set_target_properties(icedb
	PROPERTIES
		OUTPUT_NAME icedb${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
)

install(TARGETS icedb DESTINATION lib)
