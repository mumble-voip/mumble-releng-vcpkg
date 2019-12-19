# Add dependencies for C++ related project generation
if(XCODE)
    set(zeroc-ice_CONFIG_FILES
        config/Make.xcodesdk.rules
    )
endif()

# todo: add GNU Make logic to drive makefile generation

# add project wide c++ properties
include(cmake/ice_cpp_props.cmake)

if(WIN32)
    if(MSVC)
        include(cmake/mc_compiler.cmake)
    endif()
endif(WIN32)

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
${zeroc-ice_CONFIG_FILES} ${zeroc-ice_DOXYGEN_FILES}
    PROPERTIES HEADER_FILE_ONLY TRUE
)

find_package(bzip2 1.0 REQUIRED)
find_package(expat 2.1 REQUIRED)
find_package(openssl 1.0.0 REQUIRED)

add_subdirectory(src/IceUtil)
add_subdirectory(src/Slice)
add_subdirectory(src/slice2cpp)
add_subdirectory(src/Ice)
add_subdirectory(src/Glacier2Lib)
add_subdirectory(src/IceBox)
add_subdirectory(src/IceDiscovery)
add_subdirectory(src/IceGrid)
add_subdirectory(src/IceLocatorDiscovery)
add_subdirectory(src/IceSSL)
add_subdirectory(src/IceStormLib)

if(CMAKE_CXX_STANDARD EQUAL 98)
    find_package(lmdb CONFIG REQUIRED)
    add_subdirectory(src/Glacier2)
    add_subdirectory(src/Glacier2CryptPermissionsVerifier)
    add_subdirectory(src/IceBridge)
endif()
