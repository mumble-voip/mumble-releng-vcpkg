# define c++ compiler options and preprocessor definitions for all OS types

# property flags 
set(ICE_BIN_DIST "")
set(ICE_BUILDING_SRC 1) 
if(WIN32)
   set(ICE_COMPILE_DEFS 
      "_CONSOLE"
      "WIN32_LEAN_AND_MEAN"
      "ICE_CPP11_MAPPING"
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
      "/bigobj"
      "/MT"
   )

   set(CMAKE_RC_FLAGS "ICE_CPP11_MAPPING")

elseif(DARWIN)

elseif(UNIX OR LINUX)

endif()
