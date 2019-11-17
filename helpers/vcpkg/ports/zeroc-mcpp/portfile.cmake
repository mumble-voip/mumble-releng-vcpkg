include(vcpkg_common_functions)

vcpkg_from_github(
   OUT_SOURCE_PATH SOURCE_PATH
   REPO zeroc-ice/mcpp
   REF v2.7.2.13
   SHA512 8cfe5e7dc191fa43c9e2b46a99a3489e572a9fab8df6a1937a0ff03a6e9abc4843878eb5481e6bd4f87c9cc87cc3537a988523d31eb2954d55fc216eb3d4860c
   HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

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
      ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/zeroc-mcpp RENAME copyright)