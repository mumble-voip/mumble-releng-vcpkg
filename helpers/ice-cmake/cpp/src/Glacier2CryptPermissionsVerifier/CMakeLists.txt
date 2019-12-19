add_library(glacier2cryptpermissionsverifier)

add_dependencies(glacier2cryptpermissionsverifier glacier2 ice)

target_sources(glacier2cryptpermissionsverifier
    PRIVATE
        CryptPermissionsVerifierI.cpp
)

target_include_directories(glacier2cryptpermissionsverifier
    PRIVATE 
        ${PROJECT_BINARY_DIR}/generated
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src  
)

target_compile_definitions(glacier2cryptpermissionsverifier
    PRIVATE
        ${ICE_COMPILE_DEFS}
        "CRYPT_PERMISSIONS_VERIFIER_API_EXPORTS"
)

if(WIN32)
    source_group(
        TREE ${CMAKE_CURRENT_SOURCE_DIR}
        PREFIX "Resource Files"
        FILES
            CryptPermissionsVerifier.rc
    )

    target_compile_options(glacier2cryptpermissionsverifier
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}   
    )

    target_compile_definitions(glacier2cryptpermissionsverifier
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )
endif()

install(TARGETS glacier2cryptpermissionsverifier DESTINATION lib)
