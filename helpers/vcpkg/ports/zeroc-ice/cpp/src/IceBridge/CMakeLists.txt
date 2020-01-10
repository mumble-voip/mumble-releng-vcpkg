add_executable(icebridge)

target_sources(icebridge
	PRIVATE
		IceBridge.cpp
)

target_include_directories(icebridge
	PRIVATE
		${GENERATED_SLICES_DIR}
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(icebridge
	PRIVATE
		${ICE_COMPILE_DEFS}
)

target_link_libraries(icebridge
	PRIVATE
		ice
)

if(WIN32)
	target_sources(icebridge
		PRIVATE
			IceBridge.rc
	)

	target_compile_options(icebridge
		PRIVATE
			${ICE_WIN32_COMPILE_OPTIONS}
	)

	target_compile_definitions(icebridge
		PRIVATE
			${ICE_WIN32_COMPILE_DEFS}
	)

	target_link_options(icebridge
		PRIVATE
			${ICE_WIN32_LINK_OPTIONS}
	)

	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files"
		FILES
			IceBridge.rc
	)
endif()

install(TARGETS icebridge DESTINATION bin)
