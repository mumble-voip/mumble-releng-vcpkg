# define c++ compiler options and preprocessor definitions for all OS types
set(ICE_COMPILE_DEFS "ICE_BUILDING_SRC")
set(STATIC_ICE_COMPILE_DEFS "${ICE_COMPILE_DEFS}" "ICE_STATIC_LIBS")

if(CMAKE_CXX_STANDARD EQUAL 11)
    set(ICE_COMPILE_DEFS "${ICE_COMPILE_DEFS}" "ICE_CPP11_MAPPING")
elseif(CMAKE_CXX_STANDARD EQUAL 98)
    # it's c++98
endif()

if(NOT BUILD_SHARED_LIBS)
    set(ICE_COMPILE_DEFS "${ICE_COMPILE_DEFS}" "ICE_STATIC_LIBS")

    # Win32 will not statically build icebox properly in C++11
    if(CMAKE_CXX_STANDARD EQUAL 11 AND NOT WIN32)
        set(ICE_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}" "ICE_STATIC_LIBS")
    endif()
endif()

list(APPEND COMPILE_SLICES_CPP_PARAMETERS "--checksum" "--include-dir")

if(WIN32)
    set(ICE_WIN32_COMPILE_DEFS
        "_CONSOLE" 
        "WIN32_LEAN_AND_MEAN" 
    )

    set(ICE_WIN32_COMPILE_OPTIONS
        "/W4"
        "/wd4121"
        "/wd4250"
        "/wd4251"
        "/wd4275"
        "/wd4324"
        "/wd4127"
        "/wd4505"
        "/wd4512"
        "/MP"
        "/bigobj"
    )

    set(ICE_WIN32_LINK_OPTIONS
        "wsetargv.obj"
    )

    set(rc_flags " /l 0x0409")
    set(CMAKE_RC_FLAGS ${rc_flags})

    if(NOT BUILD_SHARED_LIBS)
        set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
    endif()

elseif(APPLE)

# TODO - add ICE_COMPILE_DEFS

elseif(UNIX OR LINUX)

# TODO - ICE_COMPILE_DEFS

endif()
