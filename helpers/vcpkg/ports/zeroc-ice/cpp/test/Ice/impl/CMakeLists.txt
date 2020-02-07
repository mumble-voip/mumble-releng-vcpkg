if(NOT ${CMAKE_CURRENT_BINARY_DIR}/Ice)
	file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Ice)
endif()

set(IMPL_SLICES
	${CMAKE_CURRENT_BINARY_DIR}/Test.ice
	${CMAKE_CURRENT_BINARY_DIR}/TestAMD.ice
)

set(GENERATED_IMPL_HEADERS ${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.h)
set(GENERATED_IMPL_SOURCES ${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp)

list(APPEND ICE_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICE_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "Ice" "--impl-c++${CXX_STANDARD}")

foreach(slice ${IMPL_SLICES})
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
	set(IMPL_DEPS 
		ice
		testcommon
	)
elseif(BUILD_ICE_CPP11)
	set(IMPL_DEPS 
		ice++11
		testcommon++11
	)
elseif(BUILD_ICE_UWP)
	set(IMPL_DEPS 
		iceuwp++11
		testcommonuwp++11
	)
endif()

add_executable(iceimplserver)

target_sources(iceimplserver
	PRIVATE
		Server.cpp
		${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
)

target_include_directories(iceimplserver
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Ice
		${CMAKE_CURRENT_BINARY_DIR}
		${CMAKE_CURRENT_BINARY_DIR}
)

if(BUILD_ICE_CPP98)
	set_property(TARGET iceimplserver PROPERTY CXX_STANDARD 98)
elseif(BUILD_ICE_CPP11)
	set_property(TARGET iceimplserver PROPERTY CXX_STANDARD 11)
endif()

if(BUILD_ICE_UWP)
	add_dependencies(iceimplserver ${IMPL_DEPS})
	set_property(TARGET iceimplserver PROPERTY CXX_STANDARD 11)
else()
	target_link_libraries(iceimplserver PRIVATE ${IMPL_DEPS})
endif()

target_compile_definitions(iceimplserver 
	PRIVATE 
		${ICE_COMPILE_DEFS}
		"STRING_VIEW_IGNORE_STRING_CONVERTER")

if(MSVC)
	source_group("Slice Files"
		FILES
			Test.ice
	)

	source_group("Source Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
	)

	source_group("Header Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.h
	)

	target_compile_options(iceimplserver
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
			"/wd4100"
			"/wd4503"
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET iceimplserver PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET iceimplserver PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS iceimplserver DESTINATION tests/bin)

add_executable(iceimplserveramd)

target_sources(iceimplserveramd
	PRIVATE
		ServerAMD.cpp
		${CMAKE_CURRENT_BINARY_DIR}/Ice/Test.cpp
)

target_include_directories(iceimplserveramd
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/Ice
		${CMAKE_CURRENT_BINARY_DIR}
		${CMAKE_CURRENT_BINARY_DIR}
)

if(BUILD_ICE_CPP98)
	set_property(TARGET iceimplserveramd PROPERTY CXX_STANDARD 98)
elseif(BUILD_ICE_CPP11)
	set_property(TARGET iceimplserveramd PROPERTY CXX_STANDARD 11)
endif()

if(BUILD_ICE_UWP)
	add_dependencies(iceimplserveramd ${IMPL_DEPS})
	set_property(TARGET iceimplserveramd PROPERTY CXX_STANDARD 11)
else()
	target_link_libraries(iceimplserveramd PRIVATE ${IMPL_DEPS})
endif()

target_compile_definitions(iceimplserveramd 
	PRIVATE 
		${ICE_COMPILE_DEFS}
		"STRING_VIEW_IGNORE_STRING_CONVERTER")

if(MSVC)
	source_group("Slice Files"
		FILES
			TestAMD.ice
	)

	source_group("Source Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/TestAMD.cpp
	)

	source_group("Header Files/Generated"
		FILES
			${CMAKE_CURRENT_BINARY_DIR}/Ice/TestAMD.h
	)

	target_compile_options(iceimplserveramd
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
			"/wd4100"
			"/wd4503"
	)

	if(NOT BUILD_ICE_UWP)
		set_property(TARGET iceimplserveramd PROPERTY LINK_FLAGS ${ICE_MSVC_DLL_LINK_OPTIONS})
	else()
		set_property(TARGET iceimplserveramd PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
	endif()
endif()

install(TARGETS iceimplserveramd DESTINATION tests/bin)
