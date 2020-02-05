if(BUILD_ICE_CPP98)
	set(TESTCOMMON_TARGET testcommon)
	set(TESTCOMMON_DEPS icessl ice)
elseif(BUILD_ICE_CPP11)
	set(TESTCOMMON_TARGET testcommon++11)
	set(TESTCOMMON_DEPS icessl++11 ice++11)
elseif(BUILD_ICE_UWP)
	set(TESTCOMMON_TARGET testcommonuwp++11)
	set(TESTCOMMON_DEPS icessluwp++11 iceuwp++11)
endif()

add_library(${TESTCOMMON_TARGET})

target_sources(${TESTCOMMON_TARGET} PRIVATE TestHelper.cpp)

target_include_directories(${TESTCOMMON_TARGET}
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${GENERATED_SLICES_DIR}
)

target_compile_definitions(${TESTCOMMON_TARGET}
	PRIVATE
		${ICE_COMPILE_DEFS}
		"TEST_API_EXPORTS"
)

target_link_libraries(${TESTCOMMON_TARGET} PRIVATE ${TESTCOMMON_DEPS})

if(MSVC)
	if(BUILD_SHARED_LIBS AND NOT BUILD_ICE_UWP)
		set_property(TARGET ${TESTCOMMON_TARGET} PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET ${TESTCOMMON_TARGET} PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()

	target_compile_options(${TESTCOMMON_TARGET} PRIVATE ${ICE_MSVC_COMPILE_OPTIONS})
endif()

install(TARGETS ${TESTCOMMON_TARGET} DESTINATION test/lib)
