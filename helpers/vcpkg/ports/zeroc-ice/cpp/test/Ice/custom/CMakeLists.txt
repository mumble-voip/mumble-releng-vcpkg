if(NOT ${CMAKE_CURRENT_BINARY_DIR}/Ice)
	file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Ice)
endif()

set(CUSTOM_SLICES
	${CMAKE_CURRENT_BINARY_DIR}/Test.ice
	${CMAKE_CURRENT_BINARY_DIR}/TestAMD.ice
	${CMAKE_CURRENT_BINARY_DIR}/Wstring.ice
	${CMAKE_CURRENT_BINARY_DIR}/WstringAMD.ice
)

set(GENERATED_CUSTOM_HEADERS ${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.h)
set(GENERATED_CUSTOM_SOURCES ${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp)

list(APPEND ICE_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICE_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "Ice")

foreach(slice ${CUSTOM_SLICES})
	get_filename_component(slice_name ${slice} NAME_WE)
	set(output_files 
		${CMAKE_CURRENT_BINARY_DIR}/Ice/${slice_name}.cpp 
		${CMAKE_CURRENT_BINARY_DIR}/Ice/${slice_name}.h
	)	
	#function(CompileSlice slice2bin_params slice_include_paths ice_file output_dir output_file)
	CompileSlice("${ICE_SLICE_PARAMS}"
		"${ICE_SLICE_DIRS}"
		${slice}
		${CMAKE_CURRENT_BINARY_DIR}/Ice
		"${output_files}"
	)
endforeach()

if(BUILD_ICE_CPP98)
	set(CUSTOM_DEPS 
		ice
		testcommon
	)
elseif(BUILD_ICE_CPP11)
	set(CUSTOM_DEPS 
		ice++11
		testcommon++11
	)
elseif(BUILD_ICE_UWP)
	set(CUSTOM_DEPS 
		iceuwp++11
		testcommonuwp++11
	)
endif()

add_executable(icecustomclient)

target_sources(icecustomclient
	PRIVATE
		AllTests.cpp
		Client.cpp
		MyByteSeq.cpp
		StringConverterI.cpp
		${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
		${CMAKE_CURRENT_BINARY_DIR}/Ice/Wstring.cpp
)

target_include_directories(icecustomclient
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Ice
		${CMAKE_CURRENT_BINARY_DIR}
		${CMAKE_CURRENT_BINARY_DIR}
)

if(BUILD_ICE_UWP)
	add_dependencies(icecustomclient ${CUSTOM_DEPS})
else()
	target_link_libraries(icecustomclient PRIVATE ${CUSTOM_DEPS})
endif()

target_compile_definitions(icecustomclient PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Test.ice
			Wstring.ice
	)

	source_group("Source Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Wstring.cpp
	)

	source_group("Header Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.h
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Wstring.h
	)

	target_compile_options(icecustomclient
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET icecustomclient PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET icecustomclient PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS icecustomclient DESTINATION tests/bin)

add_executable(iceccustomcollocated)

target_sources(iceccustomcollocated
	PRIVATE
		AllTests.cpp
		Collocated.cpp
		MyByteSeq.cpp
		StringConverterI.cpp
		${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
		${CMAKE_CURRENT_BINARY_DIR}/Ice/Wstring.cpp
)

target_include_directories(iceccustomcollocated
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Ice
		${CMAKE_CURRENT_BINARY_DIR}
		${CMAKE_CURRENT_BINARY_DIR}
)

if(BUILD_ICE_UWP)
	add_dependencies(iceccustomcollocated ${CUSTOM_DEPS})
else()
	target_link_libraries(iceccustomcollocated PRIVATE ${CUSTOM_DEPS})
endif()

target_compile_definitions(iceccustomcollocated PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Test.ice
			Wstring.ice
	)

	source_group("Source Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Wstring.cpp
	)

	source_group("Header Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.h
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Wstring.h
	)

	target_compile_options(iceccustomcollocated
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET iceccustomcollocated PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET iceccustomcollocated PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS iceccustomcollocated DESTINATION tests/bin)

add_executable(icecustomserver)

target_sources(icecustomserver
	PRIVATE
		MyByteSeq.cpp
		Server.cpp
		StringConverterI.cpp
		TestI.cpp
		WstringI.cpp
		${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
		${CMAKE_CURRENT_BINARY_DIR}/Ice/Wstring.cpp
)

target_include_directories(icecustomserver
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Ice
		${CMAKE_CURRENT_BINARY_DIR}
		${CMAKE_CURRENT_BINARY_DIR}
)

if(BUILD_ICE_UWP)
	add_dependencies(icecustomserver ${CUSTOM_DEPS})
else()
	target_link_libraries(icecustomserver PRIVATE ${CUSTOM_DEPS})
endif()

target_compile_definitions(icecustomserver PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Test.ice
			Wstring.ice
	)

	source_group("Source Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Wstring.cpp
	)

	source_group("Header Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.h
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Wstring.h
	)

	target_compile_options(icecustomserver
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET icecustomserver PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET icecustomserver PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS icecustomserver DESTINATION tests/bin)

add_executable(iceccustomserveramd)

target_sources(iceccustomserveramd
	PRIVATE
		MyByteSeq.cpp
		ServerAMD.cpp
		StringConverterI.cpp
		TestAMDI.cpp
		WstringAMDI.cpp
		${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
		${CMAKE_CURRENT_BINARY_DIR}/Ice/WstringAMD.cpp
)

target_include_directories(iceccustomserveramd
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Ice
		${CMAKE_CURRENT_BINARY_DIR}
		${CMAKE_CURRENT_BINARY_DIR}
)

if(BUILD_ICE_UWP)
	add_dependencies(iceccustomserveramd ${CUSTOM_DEPS})
else()
	target_link_libraries(iceccustomserveramd PRIVATE ${CUSTOM_DEPS})
endif()

target_compile_definitions(iceccustomserveramd PRIVATE ${ICE_COMPILE_DEFS})

if(MSVC)
	source_group("Slice Files"
		FILES
			Test.ice
			WstringAMD.ice
	)

	source_group("Source Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
			${CMAKE_CURRENT_BINARY_DIR}/Ice/WstringAMD.cpp
	)

	source_group("Header Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.h
			${CMAKE_CURRENT_BINARY_DIR}/Ice/WstringAMD.h
	)

	target_compile_options(iceccustomserveramd
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET iceccustomserveramd PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET iceccustomserveramd PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS iceccustomserveramd DESTINATION tests/bin)
