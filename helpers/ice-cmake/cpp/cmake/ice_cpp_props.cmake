# define c++ compiler options and preprocessor definitions for all OS types

set(CMAKE_CXX_STANDARD 11) 
if(WIN32)
   include("${PROJECT_SOURCE_DIR}/cpp/cmake/mc_compiler.cmake")
   if(MSVC)
      set(ICE_COMPILE_DEFS
         "_CONSOLE" 
         "WIN32_LEAN_AND_MEAN"
         "ICE_BUILDING_SRC"
         "_WIN32_WINNT"
      )

      if(CMAKE_CXX_STANDARD EQUAL 11)
         set(ICE_COMPILE_DEFS "${ICE_COMPILE_DEFS}" "ICE_CPP11_MAPPING")
         set(ICE_RC_FLAGS "ICE_CPP11_MAPPING")
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
         "/bigobj"
         "/MP"
      )
      if(NOT BUILD_SHARED_LIBS)
         set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /MT")
         set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} /MTd")
         set(ICE_COMPILE_DEFS "${ICE_COMPILE_DEFS}" "ICE_STATIC_LIBS")
      endif()

   endif()

elseif(DARWIN)

elseif(UNIX OR LINUX)

endif()
