add_library(iceutil STATIC)

target_sources(iceutil 
   PRIVATE
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Atomic.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Cond.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Config.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/ConsoleUtil.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/CountDownLatch.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/CtrlCHandler.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/DisableWarnings.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Exception.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/FileUtil.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Functional.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Handle.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/IceUtil.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/InputUtil.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Iterator.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Lock.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Monitor.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Mutex.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/MutexProtocol.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/MutexPtrLock.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/MutexPtrTryLock.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Optional.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Options.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/OutputUtil.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/PopDisableWarnings.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/PushDisableWarnings.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Random.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/RecMutex.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/ResourceConfig.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/ScannerConfig.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/ScopedArray.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Shared.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/StopWatch.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/StringConverter.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/StringUtil.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Thread.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/ThreadException.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Time.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/Timer.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/UndefSysMacros.h
      ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil/UUID.h   
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

target_include_directories(iceutil PRIVATE ${CMAKE_SOURCE_DIR}/cpp/include)

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
