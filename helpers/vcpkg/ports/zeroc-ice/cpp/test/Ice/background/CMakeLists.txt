if(NOT ${CMAKE_CURRENT_BINARY_DIR}/Ice)
	file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Ice)
endif()

set(GENERATED_BACKGROUND_HEADERS ${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.h)
set(GENERATED_BACKGROUND_SOURCES ${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp)

list(APPEND ICE_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICE_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "Ice")

set(output_files 
	${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp 
	${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.h
)	
#function(CompileSlice slice2bin_params slice_include_paths ice_file output_dir output_file)
CompileSlice("${ICE_SLICE_PARAMS}"
	"${ICE_SLICE_DIRS}"
	${CMAKE_CURRENT_SOURCE_DIR}/Test.ice
	${CMAKE_CURRENT_BINARY_DIR}/Ice
	"${output_files}"
)

if(BUILD_ICE_CPP98)
	set(BACKGROUND_DEPS 
		ice
		testcommon
	)
elseif(BUILD_ICE_CPP11)
	set(BACKGROUND_DEPS 
		ice++11
		testcommon++11
	)
elseif(BUILD_ICE_UWP)
	set(BACKGROUND_DEPS 
		iceuwp++11
		testcommonuwp++11
	)
endif()

add_executable(icebackgroundclient)

target_sources(icebackgroundclient
	PRIVATE
		AllTests.cpp
		Client.cpp
		${GENERATED_BACKGROUND_HEADERS}
		${GENERATED_BACKGROUND_SOURCES}
)

target_include_directories(icebackgroundclient
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Ice
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

if(BUILD_ICE_CPP98)
	set_property(TARGET icebackgroundclient PROPERTY CXX_STANDARD 98)
elseif(BUILD_ICE_CPP11)
	set_property(TARGET icebackgroundclient PROPERTY CXX_STANDARD 11)
endif()

if(BUILD_ICE_UWP)
	add_dependencies(icebackgroundclient ${BACKGROUND_DEPS})
	set_property(TARGET icebackgroundclient PROPERTY CXX_STANDARD 11)
else()
	target_link_libraries(icebackgroundclient PRIVATE ${BACKGROUND_DEPS})
endif()

target_compile_definitions(icebackgroundclient PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Test.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_BACKGROUND_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_BACKGROUND_HEADERS}
	)

	target_compile_options(icebackgroundclient
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET icebackgroundclient PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET icebackgroundclient PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS icebackgroundclient DESTINATION tests/bin)

if(BUILD_ICE_UWP)
	add_library(icebackgroundtesttransport STATIC)
else()
	add_library(icebackgroundtesttransport)
endif()

target_sources(icebackgroundtesttransport
	PRIVATE
		Acceptor.cpp
		Configuration.cpp
		EndpointFactory.cpp
		EndpointI.cpp
		PluginI.cpp
		Transceiver.cpp
		${GENERATED_BACKGROUND_HEADERS}
		${GENERATED_BACKGROUND_SOURCES}
)

target_include_directories(icebackgroundtesttransport
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Ice
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

if(BUILD_ICE_CPP98)
	set_property(TARGET icebackgroundtesttransport PROPERTY CXX_STANDARD 98)
elseif(BUILD_ICE_CPP11)
	set_property(TARGET icebackgroundtesttransport PROPERTY CXX_STANDARD 11)
endif()

if(BUILD_ICE_UWP)
	add_dependencies(icebackgroundtesttransport ${BACKGROUND_DEPS})
	set_property(TARGET icebackgroundtesttransport PROPERTY CXX_STANDARD 11)
else()
	target_link_libraries(icebackgroundtesttransport PRIVATE ${BACKGROUND_DEPS})
endif()

target_compile_definitions(icebackgroundtesttransport PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Test.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_BACKGROUND_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_BACKGROUND_HEADERS}
	)

	target_compile_options(icebackgroundtesttransport
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET icebackgroundtesttransport PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET icebackgroundtesttransport PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()


if(BUILD_SHARED_LIBS)
	install(TARGETS icebackgroundtesttransport DESTINATION test/bin)
else()
	install(TARGETS icebackgroundtesttransport DESTINATION test/lib)
endif()

add_executable(icebackgroundserver)

target_sources(icebackgroundserver
	PRIVATE
		Server.cpp
		TestI.cpp
		${GENERATED_BACKGROUND_HEADERS}
		${GENERATED_BACKGROUND_SOURCES}
)

target_include_directories(icebackgroundserver
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Ice
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

if(BUILD_ICE_CPP98)
	set_property(TARGET icebackgroundserver PROPERTY CXX_STANDARD 98)
elseif(BUILD_ICE_CPP11)
	set_property(TARGET icebackgroundserver PROPERTY CXX_STANDARD 11)
endif()

if(BUILD_ICE_UWP)
	add_dependencies(icebackgroundserver ${BACKGROUND_DEPS})
	set_property(TARGET icebackgroundserver PROPERTY CXX_STANDARD 11)
else()
	target_link_libraries(icebackgroundserver PRIVATE ${BACKGROUND_DEPS})
endif()

target_compile_definitions(icebackgroundserver PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Test.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_BACKGROUND_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_BACKGROUND_HEADERS}
	)

	target_compile_options(icebackgroundserver
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET icebackgroundserver PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET icebackgroundserver PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS icebackgroundserver DESTINATION tests/bin)
