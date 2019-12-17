add_library(slice STATIC)

target_sources(slice
    PRIVATE
        Checksum.cpp
        Checksum.h
        CPlusPlusUtil.cpp
        CPlusPlusUtil.h
        FileTracker.cpp
        FileTracker.h
        Grammar.cpp
        Grammar.h
        Grammar.y
        GrammarUtil.h
        JavaUtil.cpp
        JavaUtil.h
        MD5.cpp
        MD5.h
        MD5I.cpp
        MD5I.h
        Parser.cpp
        Parser.h
        PHPUtil.cpp
        PHPUtil.h
        Preprocessor.cpp
        Preprocessor.h
        Python.cpp
        PythonUtil.cpp
        PythonUtil.h
        Ruby.cpp
        RubyUtil.cpp
        RubyUtil.h
        Scanner.cpp
        Scanner.l
        SliceUtil.cpp
        StringLiteralUtil.cpp
        Util.h
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
