cmake_minimum_required(VERSION 3.10)
project(nanovg LANGUAGES C)
option(INSTALL_HEADERS "Install header files" ON)

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

install(TARGETS nanovg
        EXPORT NANOVGExports
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

if(INSTALL_HEADERS)
        install(FILES ${HEADERS} DESTINATION include/nanovg/)
        export(TARGETS nanovg FILE "${PROJECT_BINARY_DIR}/nanovgTargets.cmake")
        export(PACKAGE nanovg)
        # Create the Config.cmake and ConfigVersion files
        configure_file(nanovgConfig.cmake.in        "${PROJECT_BINARY_DIR}/nanovgConfig.cmake"        @ONLY)
        #configure_file(nanovgConfigVersion.cmake.in "${PROJECT_BINARY_DIR}/nanovgConfigVersion.cmake" @ONLY)

        # Install the Config.cmake and ConfigVersion.cmake
        install(FILES
                "${PROJECT_BINARY_DIR}/nanovgConfig.cmake"
                #"${PROJECT_BINARY_DIR}/nanovgConfigVersion.cmake"
                DESTINATION "${INSTALL_CMAKE_DIR}")

        install(EXPORT NANOVGExports 
                DESTINATION "${INSTALL_CMAKE_DIR}")
endif()