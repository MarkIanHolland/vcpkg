cmake_minimum_required(VERSION 3.10)
project(nanovg C)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
set(INSTALL_CMAKE_DIR share/nanovg)

set(HEADERS 
        src/nanovg.h
        src/nanovg_gl.h
        src/nanovg_gl_utils.h
)
add_library(nanovg src/nanovg.c)
set_target_properties(nanovg PROPERTIES PUBLIC_HEADER "${HEADERS}")

install(TARGETS nanovg
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib)

install(FILES ${HEADERS} DESTINATION include)