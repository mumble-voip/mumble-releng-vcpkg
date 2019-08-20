# define c++ compiler options and preprocessor definitions for all OS types

if(WIN32)
   if(MSVC)
      set(ICE_CPP98_COMPILE_DEFS
         "_CONSOLE" 
         "WIN32_LEAN_AND_MEAN"
         "ICE_BUILDING_SRC" 
      )

      if(CMAKE_CXX_STANDARD EQUAL 11)
         set(ICE_CPP11_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS}" "ICE_CPP11_MAPPING")
      endif()

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
      if(NOT BUILD_SHARED_LIBS)
         set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
         set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
         set(ICE_CPP98_COMPILE_DEFS "${ICE_CPP98_COMPILE_DEFS}" "ICE_STATIC_LIBS")
         if(CMAKE_CXX_STANDARD EQUAL 11)
            set(ICE_CPP11_COMPILE_DEFS "${ICE_CPP11_COMPILE_DEFS}" "ICE_STATIC_LIBS")
         endif()
      endif()

   endif()

elseif(DARWIN)

elseif(UNIX OR LINUX)

endif()
