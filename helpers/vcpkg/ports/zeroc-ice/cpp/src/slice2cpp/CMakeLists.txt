add_executable(slice2cpp)

set_property(TARGET slice2cpp PROPERTY CXX_STANDARD 98)

find_library(MCPP_LIB NAMES mcpp)

target_sources(slice2cpp 
	PRIVATE
		Gen.cpp
		Gen.h
		Main.cpp
)

target_include_directories(slice2cpp
	PRIVATE
		${PROJECT_SOURCE_DIR}/cpp/include
		${PROJECT_SOURCE_DIR}/cpp/src
)

target_compile_definitions(slice2cpp 
	PRIVATE 
		${STATIC_ICE_COMPILE_DEFS}
		"ICE_BUILDING_SLICE_COMPILERS"
)

target_link_libraries(slice2cpp 
	PRIVATE
		${MCPP_LIB}
		slice  
)

if(MSVC)
	source_group(
		TREE ${CMAKE_CURRENT_SOURCE_DIR}
		PREFIX "Resource Files" 
		FILES Slice2Cpp.rc
	)

	target_compile_options(slice2cpp PRIVATE "/wd4250")

	set_property(TARGET slice2cpp PROPERTY LINK_FLAGS ${ICE_MSVC_APP_LINK_OPTIONS})

	target_link_libraries(slice2cpp PRIVATE
		rpcrt4.lib
		advapi32.lib
		DbgHelp.lib
		Shlwapi.lib
	)

	target_sources(slice2cpp
		PRIVATE
			Slice2Cpp.rc
	)

	target_compile_definitions(slice2cpp
		PRIVATE
			${ICE_MSVC_COMPILE_DEFS}
	)

	target_compile_options(slice2cpp
		PRIVATE
			${ICE_MSVC_COMPILE_OPTIONS}
	)
endif()

install(TARGETS slice2cpp DESTINATION bin)
