include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO GPUOpen-LibrariesAndSDKs/V-EZ
    REF 6a3b645b91a7f7598c999901d9e79e51b00d7fb2
    SHA512 3311635c2b7547243c254e9fa7bf342c4cb23e3efd2f04900e8735c2fdde6f0b28438870ff24666a2f77b4b5059d620f05e8a2156632cd9fc1185bb596e10ca4
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DVEZ_COMPILE_SAMPLES=OFF
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/v-ez RENAME copyright)