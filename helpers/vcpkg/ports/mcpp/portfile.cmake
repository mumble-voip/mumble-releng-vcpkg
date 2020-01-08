include(vcpkg_common_functions)

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO zeroc-ice/mcpp
	REF master
	SHA512 4c665638fa71bc8d7de2d68be0124d3a43857f1fc3d8763bc55f6cd04582415ce9807d73882237098d627f7247895602088f5ef2b44b8f3a0419b08ef3679ed8
	HEAD_REF master
)

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
