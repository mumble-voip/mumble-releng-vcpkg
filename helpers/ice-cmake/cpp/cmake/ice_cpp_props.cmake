# define c++ compiler options and preprocessor definitions for all OS types
set(ICE_COMPILE_DEFS "ICE_BUILDING_SRC")

if(WIN32)
    set(ICE_CPP98_COMPILE_DEFS
        "_CONSOLE" 
        "WIN32_LEAN_AND_MEAN"
        ${ICE_COMPILE_DEFS} 
    )

    set(ICE_COMPILE_OPTIONS
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

    set(ICE_APP_ADDITIONAL_DEPS
        "wsetargv.obj"
    )

    set(rc_flags " /l 0x0409")
    set(CMAKE_RC_FLAGS ${rc_flags})

elseif(APPLE)

# TODO - add ICE_CPP98_COMPILE_DEFS

elseif(UNIX OR LINUX)

# TODO - ICE_CPP98_COMPILE_DEFS

endif()

if(CMAKE_CXX_STANDARD EQUAL 11)
    set(ICE_CPP11_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS}" "ICE_CPP11_MAPPING")
endif()

if(NOT BUILD_SHARED_LIBS)
    set(ICE_CPP98_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS}" "ICE_STATIC_LIBS")
    if(CMAKE_CXX_STANDARD EQUAL 11)
        set(ICE_CPP11_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}" "ICE_STATIC_LIBS")
    endif()
endif()
