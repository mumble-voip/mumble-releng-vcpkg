cmake_minimum_required(VERSION 3.16.0)

if(APPLE)
	set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "Minimum macOS deployment version")
endif()

if(WIN32)
    # handle debug lib naming based on shipped project naming
    if(NOT CMAKE_DEBUG_POSTFIX)
        set(CMAKE_DEBUG_POSTFIX d)
    endif()
endif()

project(mcpp VERSION 2.7.2.14)

add_library(mcpp STATIC
	"config.h"
	"configed.H"
	"directive.c"
	"eval.c"
	"expand.c"
	"internal.H"
	"main.c"
	"mbchar.c"
	"support.c"
	"system.c"
	"system.H"
)

target_sources(mcpp PUBLIC
	"${CMAKE_CURRENT_SOURCE_DIR}/mcpp_lib.h"
	"${CMAKE_CURRENT_SOURCE_DIR}/mcpp_out.h"
)

if(UNIX)
    include(GNUInstallDirs)
    
    set_property(
        TARGET mcpp
        PROPERTY PUBLIC_HEADER "mcpp_lib.h" "mcpp_out.h"
    )

	target_compile_options(mcpp PRIVATE "-O2")

	if(${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
		set_property(
			TARGET mcpp
			PROPERTY POSITION_INDEPENDENT_CODE ON
		)

		target_compile_options(mcpp PRIVATE
			"-Wno-implicit-function-declaration" # For readlink()
		)
	endif()

	install(TARGETS mcpp
		ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
		PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
	)

	install(TARGETS mcpp
		FILES "LICENSE"
		DESTINATION "${CMAKE_INSTALL_DATAROOTDIR}/mcpp"
		RENAME "copyright"
	)
elseif(WIN32)
	target_compile_definitions(mcpp PRIVATE
		"_WIN32_WINNT=0x600"
		"WIN32_LEAN_AND_MEAN"
	)

	if(MSVC)
		target_compile_definitions(mcpp PRIVATE
			"_CRT_SECURE_NO_WARNINGS"
		)

		target_compile_options(mcpp PRIVATE
			"/wd4146"
			"/wd4244"
			"/wd4267"
        )
	endif()
endif()
install(TARGETS mcpp DESTINATION lib)
