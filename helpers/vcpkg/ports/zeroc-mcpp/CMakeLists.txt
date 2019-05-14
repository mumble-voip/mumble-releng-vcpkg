cmake_minimum_required(VERSION 3.1.0 FATAL_ERROR)

project(zeroc-mcpp)
set(mcpp_VERSION_MAJOR 2)
set(mcpp_VERSION_MINOR 7)
set(mcpp_VERSION_PATCH 2)
set(mcpp_VERSION_TWEAK 12)


# referenced from https://forums.zeroc.com/discussion/comment/47118#Comment_47118
if(WIN32)
   add_compile_definitions(_WIN32_WINNT=0x600 WIN32_LEAN_AND_MEAN _CONSOLE)
endif()

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

#target_include_directories(mcpp PUBLIC ${PROJECT_SOURCE_DIR})
install(TARGETS mcpp LIBRARY DESTINATION lib)

#set_target_properties(mcpp PROPERTIES LINKER_LANGUAGE C)