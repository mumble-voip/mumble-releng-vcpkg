add_library(iceutil STATIC)

target_sources(iceutil 
    PRIVATE
        ConsoleUtil.cpp
        CtrlCHandler.cpp
        FileUtil.cpp
        InputUtil.cpp
        MutexProtocol.cpp
        Options.cpp
        OutputUtil.cpp
        Random.cpp
        RecMutex.cpp
        Shared.cpp
        StringConverter.cpp
        StringUtil.cpp
        ThreadException.cpp
        Time.cpp
        UtilException.cpp
        UUID.cpp
)

# handle win specific UTF limitations
if(${CMAKE_VS_PLATFORM_TOOLSET_VERSION} MATCHES "v100")
    target_sources(iceutil
        PRIVATE
            ConvertUTF.cpp
            ConvertUTF.h
            Unicode.cpp
            Unicode.h
    )
endif()

target_include_directories(iceutil 
    PRIVATE
        ${PROJECT_SOURCE_DIR}/cpp/include
)

if(WIN32)
    target_compile_options(iceutil 
        PRIVATE
            ${ICE_WIN32_COMPILE_OPTIONS}
    )

    target_compile_definitions(iceutil
        PRIVATE
            ${ICE_WIN32_COMPILE_DEFS}
    )

    set_property(TARGET iceutil 
        PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>"
    )
endif()

target_compile_definitions(iceutil 
    PRIVATE
        "ICE_BUILDING_SLICE_COMPILERS"
        ${STATIC_ICE_COMPILE_DEFS}
)

install(TARGETS iceutil DESTINATION lib)
