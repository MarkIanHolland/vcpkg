cmake_minimum_required(VERSION 3.10)
project(nativefiledialog LANGUAGES C CXX VERSION 1.1.2)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_C_STANDARD 11)
set(INSTALL_CMAKE_DIR share/nativefiledialog)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
set(HEADERS 
        src/include/nfd.h
)
set(SOURCE
        src/nfd_common.c
        src/nfd_common.h
        )

if(WIN32)
        add_library(nativefiledialog "${SOURCE}" src/nfd_win.cpp)
elseif(UNIX AND NOT APPLE)
        add_library(nativefiledialog "${SOURCE}" src/nfd_gtk.c)
else()
        add_library(nativefiledialog "${SOURCE}" src/nfd_cocoa.m)
endif()

set_target_properties(nativefiledialog PROPERTIES 
        VERSION ${PROJECT_VERSION}
        PUBLIC_HEADER "${HEADERS}"
        )
target_include_directories(nativefiledialog PRIVATE ${PROJECT_SOURCE_DIR}/src)
target_include_directories(nativefiledialog PRIVATE ${PROJECT_SOURCE_DIR}/src/include)

install(TARGETS nativefiledialog
        EXPORT nativefiledialogTargets
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
        PUBLIC_HEADER DESTINATION include
        )

#install(FILES ${HEADERS} DESTINATION include/nativefiledialog/)
#install(TARGETS nativefiledialog
#        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
