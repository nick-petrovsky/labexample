cmake_minimum_required( VERSION 3.11 )

# Укажем имя проекта как sdl2-demo
project( sdl2-demo C CXX)

set(LIBS_DIR ${PROJECT_SOURCE_DIR}/libs)

include(cmake/StandardProjectSettings.cmake)
include(cmake/CompilerWarnings.cmake)
include(cmake/Sanitizers.cmake)
enable_sanitizers(project_options)
include(cmake/StaticAnalyzers.cmake)

set(SDL2_VERSION "2.0.10")

#find_package( SDL2 ${SDL2_VERSION}  )
find_package( SDL2 QUIETE )
if(SDL2_FOUND)
    set (SDL2_TARGET_LINK_LIBRARIES SDL2 )
#    set (SDL2_TARGET_LINK_LIBRARIES   
#        SDL2::SDL2main SDL2::SDL2-static )
else()
    set(SDL2_DIR ${LIBS_DIR}/SDL2/install)
    include(cmake/SDL2-external.cmake)
    
    set(SDL2_INCLUDE_DIRS ${SDL2_DIR}/include/SDL2)
    set(SDL2_LIB_DIR ${SDL2_DIR}/lib)
    if(APPLE)
	find_library(ObjC Objc)
	find_library(Cocoa Cocoa)
	find_library(AudioToolbox AudioToolbox)
	find_library(CoreAudio CoreAudio)
	find_library(Carbon Carbon)
	find_library(ForceFeedback ForceFeedback)
	find_library(IOKit IOKit)
	find_library(CoreVideo CoreVideo)
	set(SDL2_TARGET_LINK_LIBRARIES m iconv 
		${ObjC} ${Cocoa} ${AudioToolbox} 
		${CoreAudio} ${Carbon} ${ForceFeedback} 
		${IOKit} ${CoreVideo}
		libSDL2.a libSDL2Main.a )  
    elseif(WIN32)
    set(SDL2_TARGET_LINK_LIBRARIES  
        SDL2d SDL2maind
        user32 gdi32 winmm imm32 ole32 oleaut32 version uuid advapi32 setupapi shell32 dinput8 )
    elseif(UNIX)
    set(SDL2_TARGET_LINK_LIBRARIES dl m pthread SDL2 )
    endif()
endif()

include_directories(${SDL2_INCLUDE_DIRS})
link_directories(${SDL2_LIB_DIR})

file(GLOB SRC_FILES ${PROJECT_SOURCE_DIR}/src/*.cpp)
add_executable( sdl2-demo ${SRC_FILES})
if (NOT SDL2_FOUND)
    add_dependencies(sdl2-demo sdl2_external_lib)
endif()

set_project_warnings( sdl2-demo )

message("{SDL2_DIR}     = ${SDL2_DIR}")
message("{SDL2_DIR}     = ${SDL2_DIR}")
message("{SDL2_LIB_DIR} = ${SDL2_LIB_DIR}")
message("{LIBS_DIR}     = ${LIBS_DIR}")
target_link_libraries( sdl2-demo ${SDL2_TARGET_LINK_LIBRARIES} )
