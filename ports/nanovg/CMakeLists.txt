cmake_minimum_required(VERSION 3.10)
project(nanovg LANGUAGES C)

set(CMAKE_C_STANDARD 11)
set(INSTALL_CMAKE_DIR share/nanovg)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
set(HEADERS 
        src/nanovg.h
        src/nanovg_gl.h
        src/nanovg_gl_utils.h
)
#target_include_directories(nanovg PRIVATE ${PROJECT_SOURCE_DIR}/src)
add_library(nanovg src/nanovg.c)

install(
        TARGETS nanovg
        EXPORT NANOVGExports
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(FILES ${HEADERS} DESTINATION ../include/nanovg)