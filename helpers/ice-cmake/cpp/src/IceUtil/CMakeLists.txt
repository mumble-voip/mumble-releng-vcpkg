add_library(iceutil STATIC)

target_sources(iceutil 
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/ConsoleUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/CtrlCHandler.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/FileUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/InputUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/MutexProtocol.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Options.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/OutputUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Random.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/RecMutex.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Shared.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/StringConverter.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/StringUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/ThreadException.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Time.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/UtilException.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/UUID.cpp
)

# handle win specific UTF limitations
if(${CMAKE_VS_PLATFORM_TOOLSET_VERSION} MATCHES "v100")
    target_sources(iceutil
        PRIVATE
            ${CMAKE_CURRENT_SOURCE_DIR}/ConvertUTF.cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/ConvertUTF.h
            ${CMAKE_CURRENT_SOURCE_DIR}/Unicode.cpp
            ${CMAKE_CURRENT_SOURCE_DIR}/Unicode.h
    )
endif()

target_include_directories(iceutil 
    PRIVATE
        ${PROJECT_SOURCE_DIR}/cpp/include
)

if(WIN32)
    target_compile_options(iceutil 
        PRIVATE
            ${ICE_COMPILE_OPTIONS}
   )
endif()

target_compile_definitions(iceutil 
    PRIVATE
        "ICE_BUILDING_SLICE_COMPILERS"
        ${ICE_CPP98_COMPILE_DEFS}
)
install(TARGETS iceutil DESTINATION lib)
