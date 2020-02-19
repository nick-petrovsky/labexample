cmake_minimum_required( VERSION 3.11 )
project( sdl2-demo C CXX)

include(ExternalProject)

set(SDL2_VERSION "2.0.10")
set(LIBS_DIR ${PROJECT_SOURCE_DIR}/libs)
set(SDL2_DIR ${LIBS_DIR}/SDL2/install)

if(EXISTS "${PROJECT_SOURCE_DIR}/external-libs/SDL2-${SDL2_VERSION}.tar.gz")
  message("File exists")
  set(CURL  "${PROJECT_SOURCE_DIR}/external-libs/SDL2-${SDL2_VERSION}.tar.gz")
else()
  message("File not exists download")
  set(CURL  "http://www.libsdl.org/release/SDL2-${SDL2_VERSION}.tar.gz")
endif()

# SDL library
ExternalProject_Add(sdl2_project
    URL ${CURL}
    PREFIX ${LIBS_DIR}/SDL2
    DOWNLOAD_DIR ${PROJECT_SOURCE_DIR}/external-libs
    CMAKE_ARGS "-DBUILD_SHARED_LIBS:BOOL=OFF" "-DCMAKE_INSTALL_PREFIX:PATH=${SDL2_DIR}"
    BUILD_BYPRODUCTS ${LIBS_DIR}/SDL2/sdl2_project-build/install/lib/SDL2d.lib
    UPDATE_DISCONNECTED ON
)

set(SDL2_INCLUDE_DIR ${SDL2_DIR}/include/SDL2)
set(SDL2_LIB_DIR ${SDL2_DIR}/lib)

include_directories(${SDL2_INCLUDE_DIR})
link_directories(${SDL2_LIB_DIR})


add_executable( sdl2-demo
    "src/main.cpp"
    "src/draw.cpp"
    )

target_link_libraries( sdl2-demo
SDL2maind SDL2d
user32 gdi32 winmm imm32 ole32 oleaut32 version uuid advapi32  setupapi shell32 dinput8
#	SDL2::SDL2main
#	SDL2::SDL2-static
)

add_dependencies(sdl2-demo sdl2_project)



