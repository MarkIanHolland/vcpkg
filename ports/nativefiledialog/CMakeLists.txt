cmake_minimum_required(VERSION 3.10)
project(nativefiledialog LANGUAGES C CXX VERSION 1.1.2)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_C_STANDARD 11)
set(INSTALL_CMAKE_DIR share/nativefiledialog)
set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS ON)
set(HEADERS 
        src/include/nfd.h
)

add_library(nativefiledialog
        src/nfd_common.c
        src/include/nfd.h
        src/nfd_common.h
        src/nfd_win.cpp
        )

set_target_properties(nativefiledialog PROPERTIES VERSION ${PROJECT_VERSION})
target_include_directories(nativefiledialog PRIVATE ${PROJECT_SOURCE_DIR})
target_include_directories(nativefiledialog PRIVATE ${PROJECT_SOURCE_DIR}/src)
target_include_directories(nativefiledialog PRIVATE ${PROJECT_SOURCE_DIR}/src/include)

install(TARGETS nativefiledialog
        EXPORT nativefiledialogTargets
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
        ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR})

install(FILES ${HEADERS} DESTINATION include/nativefiledialog/)

#install(TARGETS nativefiledialog
#        LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
#        PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
