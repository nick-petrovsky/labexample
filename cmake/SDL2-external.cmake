include(ExternalProject)
    
if(EXISTS "${PROJECT_SOURCE_DIR}/external-libs/SDL2-${SDL2_VERSION}.tar.gz")
    message("File exists")
    set(CURL  "${PROJECT_SOURCE_DIR}/external-libs/SDL2-${SDL2_VERSION}.tar.gz")
else()
    message("File not exists download")
    set(CURL  "http://www.libsdl.org/release/SDL2-${SDL2_VERSION}.tar.gz")
endif()

# SDL library
ExternalProject_Add(sdl2_external_lib
    URL ${CURL}
#    URL_MD5  5a2114f2a6f348bdab5bf52b994811db
#    PREFIX ${LIBS_DIR}/SDL2
    DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/external-libs
    CMAKE_ARGS 
        -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/external/installed
        -DBUILD_SHARED_LIBS:BOOL=OFF
        -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
        -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
        -DCMAKE_CXX_FLAGS:STRING=${CMAKE_CXX_FLAGS}
        -DCMAKE_CXX_FLAGS_DEBUG:STRING=${CMAKE_CXX_FLAGS_DEBUG}
        -DCMAKE_CXX_FLAGS_RELEASE:STRING=${CMAKE_CXX_FLAGS_RELEASE}


#    CMAKE_ARGS "-DBUILD_SHARED_LIBS:BOOL=OFF" 
#               "-DCMAKE_INSTALL_PREFIX:PATH=${SDL2_DIR}"
#    BUILD_BYPRODUCTS ${LIBS_DIR}/SDL2/sdl2_external_lib-build/install/lib/SDL2d.lib
    UPDATE_DISCONNECTED ON
)
set_target_properties(sdl2_external_lib PROPERTIES EXCLUDE_FROM_ALL TRUE)

