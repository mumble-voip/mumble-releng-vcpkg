include(vcpkg_common_functions)

vcpkg_from_github(
   OUT_SOURCE_PATH SOURCE_PATH
   REPO zeroc-ice/ice
   REF v3.7.2
   SHA512 01ff41a249b4b240d9168e7c1859b5d304281577110704787f5c05c2c93ae4f4a2e79a87f9b652f3d19b01e21615d5ee80fdcb6b531b21cca6598b79ce27358b
   HEAD_REF master
)

if(NOT VCPKG_CMAKE_SYSTEM_NAME)
   vcpkg_install_msbuild(
      SOURCE_PATH ${SOURCE_PATH}
	  PROJECT_SUBPATH cpp/msbuild/ice.proj
	  TARGET BuildDist
   )
   
elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
   vcpkg_install_msbuild(
      SOURCE_PATH ${SOURCE_PATH}
	  PROJECT_SUBPATH cpp/msbuild/ice.proj
	  TARGET UWPBuildDist
   )
   
elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Linux")
   message(STATUS "Building ${TARGET_TRIPLET}...")
   vcpkg_execute_required_process(
      COMMAND "make CONFIGS=cpp11-static -j8"
	  WORKING_DIRECTORY ${SOURCE_PATH}
   )
   message(STATUS "Building ${TARGET_TRIPLET} done")
   
elseif(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "Darwin")
   message(STATUS "Building ${TARGET_TRIPLET}...")
   vcpkg_execute_required_process(
      COMMAND "make CONFIGS=cpp11-xcodesdk -j8 srcs"
	  WORKING_DIRECTORY ${SOURCE_PATH}
   )
   message(STATUS "Building ${TARGET_TRIPLET} done")
endif()


file(
   INSTALL 
      ${SOURCE_PATH}/cpp/include/Glacier2
      ${SOURCE_PATH}/cpp/include/Ice
	  ${SOURCE_PATH}/cpp/include/IceBox
	  ${SOURCE_PATH}/cpp/include/IceBT
	  ${SOURCE_PATH}/cpp/include/IceGrid
	  ${SOURCE_PATH}/cpp/include/IceIAP
	  ${SOURCE_PATH}/cpp/include/IcePatch2
	  ${SOURCE_PATH}/cpp/include/IceSSL
	  ${SOURCE_PATH}/cpp/include/IceStorm
	  ${SOURCE_PATH}/cpp/include/IceUtil
   DESTINATION 
      ${CURRENT_PACKAGES_DIR}/include
)
if(NOT VCPKG_CMAKE_SYSTEM_NAME OR VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
   if(VCPKG_LIBRARY_LINKAGE STREQUAL static)
      file(
	     REMOVE_RECURSE
		    ${CURRENT_PACKAGES_DIR}/bin
			${CURRENT_PACKAGES_DIR}/debug/bin
	   )
   endif()
endif()   
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/zeroc-ice RENAME copyright)
file(INSTALL ${SOURCE_PATH}/LICENSE_ICE DESTINATION ${CURRENT_PACKAGES_DIR}/share/zeroc-ice)