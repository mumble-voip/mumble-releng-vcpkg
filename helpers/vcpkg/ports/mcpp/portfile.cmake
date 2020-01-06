include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO zeroc-ice/mcpp
    REF v2.7.2.14
    SHA512 859914c6d10e5068b47c33e987460eb4c29fcfce23d89bae1b0add968e84571f0ed275145f13750f250ba8a6a534556aa2e45b0d00b51c0903a7a2e8508b0b08
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

if(WIN32)
    vcpkg_check_linkage(ONLY_DYNAMIC_CRT)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()

file(
    INSTALL 
        ${SOURCE_PATH}/config.h 
        ${SOURCE_PATH}/mcpp_lib.h
        ${SOURCE_PATH}/mcpp_out.h
   
    DESTINATION 
        ${CURRENT_PACKAGES_DIR}/include
)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/mcpp RENAME copyright)
