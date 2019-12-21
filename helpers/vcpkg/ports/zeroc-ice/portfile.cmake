include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO zeroc-ice/ice
    REF v3.7.3
    # TODO - update sha512 signature
    SHA512 ef43bb28b4a20dcca5078ca2b0ad81269a435317761fc00b4d4bdf85bcdf4dddbf3b3ee6729477bd0957ea519a3705416883ba404386a05914a2c010cb785e27
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/cmake DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/cpp DESTINATION ${SOURCE_PATH})
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

# cpp11 mapping for static win32 builds is currently broken, build as cpp98

if(WIN32 AND VCPKG_LIBRARY_LINKAGE EQUAL "static")
    vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
        OPTIONS
            -DCMAKE_CXX_STANDARD=98
    )

else()
    vcpkg_configure_cmake(
        SOURCE_PATH ${SOURCE_PATH}
    )
endif()

vcpkg_install_cmake()

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
  
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/zeroc-ice RENAME copyright)
file(INSTALL ${SOURCE_PATH}/ICE_LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/zeroc-ice)