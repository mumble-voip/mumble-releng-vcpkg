include(vcpkg_common_functions)

vcpkg_from_github(
   OUT_SOURCE_PATH SOURCE_PATH
   REPO zeroc-ice/mcpp
   REF v2.7.2.13
   SHA512 8cfe5e7dc191fa43c9e2b46a99a3489e572a9fab8df6a1937a0ff03a6e9abc4843878eb5481e6bd4f87c9cc87cc3537a988523d31eb2954d55fc216eb3d4860c
   HEAD_REF master
)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

if(NOT VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
   set(VCPKG_CRT_LINKAGE dynamic)
   vcpkg_install_msbuild(
      SOURCE_PATH ${SOURCE_PATH}
	  PROJECT_SUBPATH msbuild/mcpp.sln
   )

elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Darwin" OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
   #set(BUILD_SCRIPT ${CMAKE_CURRENT_LIST_DIR}\\build.sh)
   message(STATUS "Building ${TARGET_TRIPLET}...")
   vcpkg_execute_required_process(
      COMMAND "make"
	  WORKING_DIRECTORY ${SOURCE_PATH}
   )
   message(STATUS "Building ${TARGET_TRIPLET} done")
endif()


file(
   INSTALL 
      ${SOURCE_PATH}/config.h 
	  ${SOURCE_PATH}/mcpp_lib.h
	  ${SOURCE_PATH}/mcpp_out.h
   
   DESTINATION 
      ${CURRENT_PACKAGES_DIR}/include)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/zeroc-mcpp RENAME copyright)