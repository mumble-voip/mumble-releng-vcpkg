
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

target_compile_definitions(iceboxlib PRIVATE "ICEBOX_API_EXPORTS")

add_executable(icebox Service.cpp)

target_sources(icebox 
   PRIVATE
      IceBoxExe.rc
	  Service.cpp
	  ServiceManagerI.cpp
	  ServiceManagerI.h
)

add_dependencies(icebox iceboxlib)

target_link_libraries(icebox 
	PRIVATE 
	iceboxlib
	${ICE_PROJECT_NAME}
)

target_include_directories(icebox
   PRIVATE 
   	"${CMAKE_SOURCE_DIR}/include"
		"${CMAKE_SOURCE_DIR}/src"
)

target_compile_definitions(icebox PRIVATE "ICE_BUILDING_SRC")
