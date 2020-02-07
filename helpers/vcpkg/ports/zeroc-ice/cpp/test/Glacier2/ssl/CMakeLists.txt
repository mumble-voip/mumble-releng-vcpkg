if(BUILD_ICE_CPP98)
	set(SSL_DEPS 
		glacier2 
		ice
		icediscovery
		icelocatordiscovery
		icessl
		testcommon
	)
elseif(BUILD_ICE_CPP11)
	set(SSL_DEPS 
		glacier2++11 
		ice++11
		icediscovery++11
		icelocatordiscovery++11
		icessl++11
		testcommon++11
	)
elseif(BUILD_ICE_UWP)
	set(SSL_DEPS 
		glacier2uwp++11 
		iceuwp++11
		icediscoveryuwp++11
		icelocatordiscoveryuwp++11
		icessluwp++11
		testcommonuwp++11
	)
endif()

add_executable(glacier2sslclient)

target_sources(glacier2sslclient PRIVATE Client.cpp)

target_include_directories(glacier2sslclient
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${GENERATED_SLICES_DIR}
)

if(BUILD_ICE_CPP98)
	set_property(TARGET glacier2sslclient PROPERTY CXX_STANDARD 98)
elseif(BUILD_ICE_CPP11)
	set_property(TARGET glacier2sslclient PROPERTY CXX_STANDARD 11)
endif()

if(BUILD_ICE_UWP)
	add_dependencies(glacier2sslclient ${SSL_DEPS})
	set_property(TARGET glacier2sslclient PROPERTY CXX_STANDARD 11)
else()
	target_link_libraries(glacier2sslclient PRIVATE ${SSL_DEPS})
endif()

target_compile_definitions(glacier2sslclient PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	if(NOT BUILD_ICE_UWP)
		set_property(TARGET glacier2sslclient PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET glacier2sslclient PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS glacier2sslclient DESTINATION tests/bin)

add_executable(glacier2sslserver)

target_sources(glacier2sslserver PRIVATE Server.cpp)

target_include_directories(glacier2sslserver
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${GENERATED_SLICES_DIR}
)

if(BUILD_ICE_CPP98)
	set_property(TARGET glacier2sslserver PROPERTY CXX_STANDARD 98)
elseif(BUILD_ICE_CPP11)
	set_property(TARGET glacier2sslserver PROPERTY CXX_STANDARD 11)
endif()

if(BUILD_ICE_UWP)
	add_dependencies(glacier2sslserver ${SSL_DEPS})
	set_property(TARGET glacier2sslserver PROPERTY CXX_STANDARD 11)
else()
	target_link_libraries(glacier2sslserver PRIVATE ${SSL_DEPS})
endif()

target_compile_definitions(glacier2sslserver PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	if(NOT BUILD_ICE_UWP)
		set_property(TARGET glacier2sslserver PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET glacier2sslserver PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS glacier2sslserver DESTINATION tools/bin)
