cmake_minimum_required(VERSION 3.1.0)

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
	set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "Minimum OS X deployment version")
endif()

project(zeroc-mcpp)
set(mcpp_VERSION_MAJOR 2)
set(mcpp_VERSION_MINOR 7)
set(mcpp_VERSION_PATCH 2)
set(mcpp_VERSION_TWEAK 13)

add_library(mcpp STATIC)
target_sources(mcpp 
   PRIVATE
      config.h
	   configed.H
      directive.c
	   eval.c
	   expand.c
	   internal.H
	   main.c
	   mbchar.c
	   mcpp_lib.h
	   mcpp_out.h
	   support.c 
	   system.c
	   system.H
)

target_compile_definitions(mcpp PRIVATE "HAVE_CONFIG_H" "MCPP_LIB=1")

if(WIN32)
	target_compile_definitions(mcpp PRIVATE 
		"_CONSOLE"
		"WIN32_LEAN_AND_MEAN"
		"_CRT_SECURE_NO_WARNINGS")
	target_compile_options(mcpp PRIVATE "/W3" "/wd4146" "/wd4244" "/wd4267")

elseif(UNIX)
   target_compile_options(mcpp PRIVATE "-O2" "-Wall" "-Wno-implicit-function-declaration")
   if(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
      set_property(TARGET mcpp PROPERTY POSITION_INDEPENDENT_CODE ON)
   endif()
endif()

install(TARGETS mcpp DESTINATION ${PROJECT_BINARY_DIR}/lib)
