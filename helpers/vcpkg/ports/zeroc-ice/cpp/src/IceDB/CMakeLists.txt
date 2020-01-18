if(NOT WINDOWS_STORE)
	add_library(icedb)

	set_property(TARGET icedb PROPERTY CXX_STANDARD 98)

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
	)

	if(BUILD_SHARED_LIBS)
		target_compile_definitions(icedb PRIVATE "ICE_DB_API_EXPORTS")
	endif()

	target_link_libraries(icedb
		PRIVATE
			ice
			iceutil
			lmdb
	)

	if(MSVC)
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
				${ICE_MSVC_COMPILE_OPTIONS}
		)

		target_compile_definitions(icedb
			PRIVATE
				${ICE_MSVC_COMPILE_DEFS}
		)
	endif()

	set_target_properties(icedb
		PROPERTIES
			OUTPUT_NAME IceDB${zeroc-ice_VERSION_MAJOR}${zeroc-ice_VERSION_MINOR}
	)

	install(TARGETS icedb DESTINATION lib)
endif()
