add_library(slice STATIC)

target_sources(slice
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}/Checksum.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Checksum.h
        ${CMAKE_CURRENT_SOURCE_DIR}/CPlusPlusUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/CPlusPlusUtil.h
        ${CMAKE_CURRENT_SOURCE_DIR}/FileTracker.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/FileTracker.h
        ${CMAKE_CURRENT_SOURCE_DIR}/Grammar.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Grammar.h
        ${CMAKE_CURRENT_SOURCE_DIR}/Grammar.y
        ${CMAKE_CURRENT_SOURCE_DIR}/GrammarUtil.h
        ${CMAKE_CURRENT_SOURCE_DIR}/JavaUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/JavaUtil.h
        ${CMAKE_CURRENT_SOURCE_DIR}/MD5.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/MD5.h
        ${CMAKE_CURRENT_SOURCE_DIR}/MD5I.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/MD5I.h
        ${CMAKE_CURRENT_SOURCE_DIR}/Parser.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Parser.h
        ${CMAKE_CURRENT_SOURCE_DIR}/PHPUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/PHPUtil.h
        ${CMAKE_CURRENT_SOURCE_DIR}/Preprocessor.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Preprocessor.h
        ${CMAKE_CURRENT_SOURCE_DIR}/Python.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/PythonUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/PythonUtil.h
        ${CMAKE_CURRENT_SOURCE_DIR}/Ruby.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/RubyUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/RubyUtil.h
        ${CMAKE_CURRENT_SOURCE_DIR}/Scanner.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Scanner.l
        ${CMAKE_CURRENT_SOURCE_DIR}/SliceUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/StringLiteralUtil.cpp
        ${CMAKE_CURRENT_SOURCE_DIR}/Util.h
)

target_include_directories(slice 
    PRIVATE 
        ${PROJECT_SOURCE_DIR}/cpp/include
        ${PROJECT_SOURCE_DIR}/cpp/src
)

if(WIN32)
    target_compile_options(slice 
        PRIVATE 
            "/wd4250"
            ${ICE_COMPILE_OPTIONS}
   )

endif()

target_compile_definitions(slice 
    PRIVATE 
        "ICE_BUILDING_SLICE_COMPILERS" 
        ${ICE_CPP98_COMPILE_DEFS}
)
install(TARGETS slice DESTINATION lib)
