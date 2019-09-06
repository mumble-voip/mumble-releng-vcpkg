add_library(iceutil STATIC)

target_sources(iceutil 
   PRIVATE
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Atomic.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Cond.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Config.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/ConsoleUtil.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/CountDownLatch.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/CtrlCHandler.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/DisableWarnings.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Exception.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/FileUtil.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Functional.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Handle.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/IceUtil.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/InputUtil.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Iterator.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Lock.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Monitor.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Mutex.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/MutexProtocol.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/MutexPtrLock.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/MutexPtrTryLock.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Optional.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Options.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/OutputUtil.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/PopDisableWarnings.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/PushDisableWarnings.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Random.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/RecMutex.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/ResourceConfig.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/ScannerConfig.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/ScopedArray.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Shared.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/StopWatch.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/StringConverter.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/StringUtil.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Thread.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/ThreadException.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Time.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/Timer.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/UndefSysMacros.h
      ${PROJECT_SOURCE_DIR}/cpp/include/IceUtil/UUID.h   
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

target_include_directories(iceutil PRIVATE ${PROJECT_SOURCE_DIR}/cpp/include)

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
