
project(IceBox)

add_library(iceboxlib)

target_sources(iceboxlib
   PRIVATE
	  Exception.cpp
	  IceBox.rc
	  IceBoxAdmin.rc
)

target_include_directories(iceboxlib
   PRIVATE 
      "${CMAKE_SOURCE_DIR}/include"
	  "${CMAKE_SOURCE_DIR}/src"
)

add_dependencies(iceboxlib ice)

target_link_libraries(iceboxlib PRIVATE ice)

target_compile_definitions(iceboxlib PRIVATE "ICEBOX_API_EXPORTS")

add_executable(icebox Service.cpp)

target_sources(icebox 
   PRIVATE
      IceBoxExe.rc
	  Service.cpp
	  ServiceManagerI.cpp
	  ServiceManagerI.h
)

add_dependencies(icebox PRIVATE iceboxlib)

target_link_libraries(icebox PRIVATE iceboxlib)

target_include_directories(icebox
   PRIVATE 
      "${CMAKE_SOURCE_DIR}/include"
	  "${CMAKE_SOURCE_DIR}/src"
)

target_compile_definitions(icebox PRIVATE "ICE_BUILDING_SRC")
