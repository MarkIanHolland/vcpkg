include(vcpkg_common_functions)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO memononen/nanovg
    REF 6fa3b3d51981ef696a2deb63fe50e1d9d62ff6a9
    SHA512 4fa459c7486c75bb334876fb1ee38d34b1cdba9e87a3bda03cd2e794ff5236515ca61c0cbec4481f37fbb8544224cc5eb3eba227187625c3427b8acbee35dd68
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

# Handle copyright
file(COPY ${SOURCE_PATH}/README.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/nanovg/)
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/nanovg RENAME copyright)
