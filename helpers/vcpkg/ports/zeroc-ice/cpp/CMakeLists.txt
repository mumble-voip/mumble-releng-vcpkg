# Add dependencies for C++ related project generation
if(XCODE)
	set(zeroc-ice_CONFIG_FILES config/Make.xcodesdk.rules)
endif()

# create include/generated folder for generated headers
if(NOT ${PROJECT_BINARY_DIR}/generated)
	file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated)
endif()

set(GENERATED_SLICES_DIR 
	${PROJECT_BINARY_DIR}/generated
)

# add project wide c++ properties
include(cmake/ice_cpp_props.cmake)

if(MSVC)
	include(cmake/mc_compiler.cmake)
endif()

set(zeroc-ice_DOXYGEN_FILES
	doxygen/config-cpp11
	doxygen/config-cpp98
	doxygen/mainpage-cpp11.md
	doxygen/mainpage-cpp98.md
)

set(zeroc-ice_CONFIG_FILES
	config/glacer2router.cfg
	config/ice_ca.cnf
	config/icegridnode.cfg
	config/icegridregistry.cfg
	config/templates.xml
)

set_source_files_properties(
	${zeroc-ice_CONFIG_FILES} 
	${zeroc-ice_DOXYGEN_FILES}
	PROPERTIES HEADER_FILE_ONLY TRUE
)

find_package(BZip2 REQUIRED)
find_package(EXPAT REQUIRED)
find_package(lmdb CONFIG REQUIRED)
find_package(OpenSSL REQUIRED)


add_subdirectory(src/IceUtil)
add_subdirectory(src/Slice)
add_subdirectory(src/slice2cpp)
add_subdirectory(src/Ice)
add_subdirectory(src/Glacier2Lib)
add_subdirectory(src/IceBox)
add_subdirectory(src/IceDiscovery)
add_subdirectory(src/IceGridLib)
add_subdirectory(src/IceLocatorDiscovery)
add_subdirectory(src/IceSSL)
add_subdirectory(src/IceStormLib)
add_subdirectory(src/Glacier2)
add_subdirectory(src/Glacier2CryptPermissionsVerifier)
add_subdirectory(src/IceBridge)
add_subdirectory(src/IceDB)
add_subdirectory(src/IceGrid)
add_subdirectory(src/icegriddb)
add_subdirectory(src/IcePatch2Lib)
add_subdirectory(src/IcePatch2)
add_subdirectory(src/IceStorm)
add_subdirectory(src/IceXML)

if(MSVC AND NOT WINDOWS_STORE)
	add_subdirectory(src/iceserviceinstall)
endif()
