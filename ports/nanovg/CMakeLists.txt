cmake_minimum_required(VERSION 3.10)
project(nanovg LANGUAGES C VERSION 2018.04.30)

set(CMAKE_C_STANDARD 11)
set(INSTALL_CMAKE_DIR share/nanovg)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)

file(GLOB HEADERS ${PROJECT_SOURCE_DIR}src/*.h)
file(GLOB SOURCES ${PROJECT_SOURCE_DIR}src/*.c)

add_library(nanovg
        src/nanovg.c
        src/nanovg.h
        src/nanovg_gl.h
        src/nanovg_gl_utils.h
        src/fontstash.h
        src/stb_image.h
        src/stb_truetype.h)

set_target_properties(nanovg PROPERTIES VERSION ${PROJECT_VERSION})
target_include_directories(nanovg PRIVATE ${PROJECT_SOURCE_DIR})
target_include_directories(nanovg PRIVATE ${PROJECT_SOURCE_DIR}/src)

install(
        TARGETS nanovg
        EXPORT NANOVGExports
        RUNTIME DESTINATION "bin"
        LIBRARY DESTINATION "lib"
        ARCHIVE DESTINATION "lib"
)

install(
        FILES   ${HEADERS}
        DESTINATION "include"
)

#install(TARGETS nanovg
#        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
