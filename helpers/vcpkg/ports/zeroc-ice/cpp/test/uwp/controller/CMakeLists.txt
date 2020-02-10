if(NOT ${CMAKE_CURRENT_BINARY_DIR}/uwp)
	file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/uwp)
endif()

set(GENERATED_CONTROLLER_HEADERS ${CMAKE_CURRENT_BINARY_DIR}/uwp/Controller.h)
set(GENERATED_CONTROLLER_SOURCES ${CMAKE_CURRENT_BINARY_DIR}/uwp/Controller.cpp)

list(APPEND ICE_SLICE_DIRS "-I${SLICE_DIR}")
list(APPEND ICE_SLICE_PARAMS ${COMPILE_SLICES_CPP_PARAMETERS} "uwp")

set(output_files 
	${CMAKE_CURRENT_BINARY_DIR}/uwp/Controller.cpp 
	${CMAKE_CURRENT_BINARY_DIR}/uwp/Controller.h
)	
#function(Compileuwp slice2bin_params slice_include_paths ice_file output_dir output_file)
CompileSlice("${ICE_SLICE_PARAMS}"
	"${ICE_SLICE_DIRS}"
	${PROJECT_SOURCE_DIR}/scripts/Controller.ice
	${CMAKE_CURRENT_BINARY_DIR}/uwp
	"${output_files}"
)

add_executable(uwpcontrollerclient)

target_sources(uwpcontrollerclient
	PRIVATE
		# App.xaml
		# App.xaml.cpp
		# ControllerView.xaml
		# ControllerView.xaml.cpp
		# pch.cpp
		# StandardStyles.xaml
		${GENERATED_CONTROLLER_HEADERS}
		${GENERATED_CONTROLLER_SOURCES}
)

target_include_directories(uwpcontrollerclient
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/test/include
		${CMAKE_CURRENT_SOURCE_DIR}
		${CMAKE_CURRENT_BINARY_DIR}/uwp
		${CMAKE_CURRENT_BINARY_DIR}
		${GENERATED_SLICES_DIR}
)

set_property(TARGET uwpcontrollerclient PROPERTY CXX_STANDARD 11)

target_link_libraries(uwpcontrollerclient 
	PRIVATE 
		testcommonuwp++11 
		iceuwp++11
)

target_compile_definitions(uwpcontrollerclient 
	PRIVATE 
		${ICE_COMPILE_DEFS}
		"TESTSUITE_DIR=${CMAKE_CURRENT_BINARY_DIR}"
)

if(MSVC)
	source_group("uwp Files"
		FILES
			Controller.ice
	)

	source_group("Source Files/Generated"
		FILES
			${GENERATED_CONTROLLER_SOURCES}
	)

	source_group("Header Files/Generated"
		FILES
			${GENERATED_CONTROLLER_HEADERS}
	)

	target_compile_options(uwpcontrollerclient
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
			"/FC"
	)

	set_property(TARGET uwpcontrollerclient PROPERTY LINK_FLAGS ${ICE_UWP_LINK_OPTIONS})
endif()

install(TARGETS uwpcontrollerclient DESTINATION tests/bin)
