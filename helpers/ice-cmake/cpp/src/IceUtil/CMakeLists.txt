add_library(iceutil STATIC)

set(ICEUTIL_HEADER_DIR ${CMAKE_SOURCE_DIR}/cpp/include/IceUtil)

target_sources(iceutil 
   PRIVATE
      ${ICEUTIL_HEADER_DIR}/Atomic.h
      ${ICEUTIL_HEADER_DIR}/Cond.h
      ${ICEUTIL_HEADER_DIR}/Config.h
      ${ICEUTIL_HEADER_DIR}/ConsoleUtil.h
      ${ICEUTIL_HEADER_DIR}/CountDownLatch.h
      ${ICEUTIL_HEADER_DIR}/CtrlCHandler.h
      ${ICEUTIL_HEADER_DIR}/DisableWarnings.h
      ${ICEUTIL_HEADER_DIR}/Exception.h
      ${ICEUTIL_HEADER_DIR}/FileUtil.h
      ${ICEUTIL_HEADER_DIR}/Functional.h
      ${ICEUTIL_HEADER_DIR}/Handle.h
      ${ICEUTIL_HEADER_DIR}/IceUtil.h
      ${ICEUTIL_HEADER_DIR}/InputUtil.h
      ${ICEUTIL_HEADER_DIR}/Iterator.h
      ${ICEUTIL_HEADER_DIR}/Lock.h
      ${ICEUTIL_HEADER_DIR}/Monitor.h
      ${ICEUTIL_HEADER_DIR}/Mutex.h
      ${ICEUTIL_HEADER_DIR}/MutexProtocol.h
      ${ICEUTIL_HEADER_DIR}/MutexPtrLock.h
      ${ICEUTIL_HEADER_DIR}/MutexPtrTryLock.h
      ${ICEUTIL_HEADER_DIR}/Optional.h
      ${ICEUTIL_HEADER_DIR}/Options.h
      ${ICEUTIL_HEADER_DIR}/OutputUtil.h
      ${ICEUTIL_HEADER_DIR}/PopDisableWarnings.h
      ${ICEUTIL_HEADER_DIR}/PushDisableWarnings.h
      ${ICEUTIL_HEADER_DIR}/Random.h
      ${ICEUTIL_HEADER_DIR}/RecMutex.h
      ${ICEUTIL_HEADER_DIR}/ResourceConfig.h
      ${ICEUTIL_HEADER_DIR}/ScannerConfig.h
      ${ICEUTIL_HEADER_DIR}/ScopedArray.h
      ${ICEUTIL_HEADER_DIR}/Shared.h
      ${ICEUTIL_HEADER_DIR}/StopWatch.h
      ${ICEUTIL_HEADER_DIR}/StringConverter.h
      ${ICEUTIL_HEADER_DIR}/StringUtil.h
      ${ICEUTIL_HEADER_DIR}/Thread.h
      ${ICEUTIL_HEADER_DIR}/ThreadException.h
      ${ICEUTIL_HEADER_DIR}/Time.h
      ${ICEUTIL_HEADER_DIR}/Timer.h
      ${ICEUTIL_HEADER_DIR}/UndefSysMacros.h
      ${ICEUTIL_HEADER_DIR}/UUID.h   
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
   target_compile_options(iceutil PRIVATE 
      ${ICE_COMPILE_OPTIONS}
   )
endif()

target_compile_definitions(iceutil 
   PRIVATE 
      "ICE_BUILDING_SLICE_COMPILERS"
      ${ICE_CPP98_COMPILE_DEFS}
)
install(TARGETS iceutil DESTINATION lib)
