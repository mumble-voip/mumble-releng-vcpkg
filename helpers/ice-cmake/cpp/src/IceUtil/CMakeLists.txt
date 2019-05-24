
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
target_include_directories(iceutil PRIVATE "${CMAKE_SOURCE_DIR}/cpp/include")
if(WIN32)
   target_compile_definitions(iceutil PRIVATE "ICE_BUILDING_SLICE_COMPILERS" "ICE_STATIC_LIBS")
endif()
