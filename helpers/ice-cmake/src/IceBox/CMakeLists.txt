
project(IceBox)

add_executable(icebox)

target_sources(icebox 
   PRIVATE
      Admin.cpp
	  Exception.cpp
	  IceBox.rc
	  IceBoxAdmin.rc
	  IceBoxExe.rc
	  Service.cpp
	  ServiceManagerI.cpp
	  ServiceManagerI.h
)

add_dependencies(icebox iceboxlib)

target_link_libraries(icebox PRIVATE iceboxlib)

target_include_directories(icebox
   PRIVATE 
      #"${CMAKE_SOURCE_DIR}/include"
	  "${CMAKE_SOURCE_DIR}/include/generated"
	  "${CMAKE_SOURCE_DIR}/src"
)

target_compile_definitions(icebox PRIVATE "ICE_BUILDING_SRC")
