# set build types
option(BUILD_ICE_CPP98 ON) # build by default
option(BUILD_ICE_CPP11 OFF)
option(BUILD_ICE_UWP OFF)

# set option for MSVC static lib, dynamic crt
option(MSVC_STATIC_DYN_CRT OFF)

if(BUILD_ICE_UWP)
	set(CMAKE_SYSTEM_NAME "WindowsStore")
	set(CMAKE_SYSTEM_VERSION "10")
endif()

if(BUILD_ICE_CPP11 OR BUILD_ICE_UWP)
	set(BUILD_ICE_CPP98 OFF)
endif()

if(BUILD_ICE_ALL)
	set(BUILD_ICE_CPP98 ON)
	set(BUILD_ICE_CPP11 ON)
	set(BUILD_ICE_UWP ON)
endif()

# create include/generated folder for generated headers
if(NOT ${PROJECT_BINARY_DIR}/generated)
	file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/generated)
endif()

# set build directories
if(BUILD_ICE_CPP98)
	# install dirs
	set(${ICE_RUNTIME_INSTALL_DIR} ${PROJECT_BINARY_DIR}/bin/cpp98)
	set(${ICE_LIBRARY_INSTALL_DIR} ${PROJECT_BINARY_DIR}/lib/cpp98)
	set(${ICE_ARCHIVE_INSTALL_DIR} ${PROJECT_BINARY_DIR}/lib/cpp98)

	# generated sources build dir
	set(GENERATED_SLICES_DIR ${PROJECT_BINARY_DIR}/generated/cpp98)

	# generated headers install dir
	set(GENERATED_H_INSTALL_DIR ${PROJECT_BINARY_DIR}/include/cpp98)
elseif(BUILD_ICE_CPP11)
	set(${ICE_RUNTIME_INSTALL_DIR} ${PROJECT_BINARY_DIR}/bin/cpp11)
	set(${ICE_LIBRARY_INSTALL_DIR} ${PROJECT_BINARY_DIR}/lib/cpp11)
	set(${ICE_ARCHIVE_INSTALL_DIR} ${PROJECT_BINARY_DIR}/lib/cpp11)

	# generated sources build dir
	set(GENERATED_SLICES_DIR ${PROJECT_BINARY_DIR}/generated/cpp11)

	# generated headers install dir
	set(GENERATED_H_INSTALL_DIR ${PROJECT_BINARY_DIR}/include/cpp11)
elseif(BUILD_ICE_UWP)
	set(${ICE_RUNTIME_INSTALL_DIR} ${PROJECT_BINARY_DIR}/bin/uwp)
	set(${ICE_LIBRARY_INSTALL_DIR} ${PROJECT_BINARY_DIR}/lib/uwp)
	set(${ICE_ARCHIVE_INSTALL_DIR} ${PROJECT_BINARY_DIR}/lib/uwp)

	# generated sources build dir
	set(GENERATED_SLICES_DIR ${PROJECT_BINARY_DIR}/generated/uwp)

	# generated headers install dir
	set(GENERATED_H_INSTALL_DIR ${PROJECT_BINARY_DIR}/include/uwp)
endif()

# Add dependencies for C++ related project generation
if(XCODE)
	set(zeroc-ice_CONFIG_FILES config/Make.xcodesdk.rules)
endif()

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

if(NOT WINDOWS_STORE)
	find_package(BZip2 REQUIRED)
	find_package(EXPAT REQUIRED)
	find_package(OpenSSL REQUIRED)
	if(NOT BUILD_ICE_CPP11)
		find_package(lmdb CONFIG REQUIRED)
	endif()
endif()

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
add_subdirectory(src/IceGrid)

if(BUILD_ICE_CPP98)
	add_subdirectory(src/Glacier2)
	add_subdirectory(src/Glacier2CryptPermissionsVerifier)
	add_subdirectory(src/IceBridge)
	add_subdirectory(src/IceDB)
	add_subdirectory(src/icegriddb)
	add_subdirectory(src/IceXML)
	add_subdirectory(src/IcePatch2)
	add_subdirectory(src/IcePatch2Lib)
	add_subdirectory(src/IceStorm)
	if(MSVC)
		add_subdirectory(src/iceserviceinstall)
	endif()
endif()
