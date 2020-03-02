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
    PREFIX ${LIBS_DIR}/SDL2
    DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/external-libs
    CMAKE_ARGS "-DBUILD_SHARED_LIBS:BOOL=OFF" 
               "-DCMAKE_INSTALL_PREFIX:PATH=${SDL2_DIR}"
    BUILD_BYPRODUCTS ${LIBS_DIR}/SDL2/sdl2_external_lib-build/install/lib/SDL2d.lib
    UPDATE_DISCONNECTED ON
)

set(SDL2_DIR ${LIBS_DIR}/SDL2/install)