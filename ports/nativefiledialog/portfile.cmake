include(vcpkg_common_functions)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mlabbe/nativefiledialog
    REF 5cfe5002eb0fac1e49777a17dec70134147931e2
    SHA512 33d1e3fd7ad12a940ae28a4d258d3e28db57d1f81ffca5984193140ca2d1a33b9aa8463ebdf8a02afd6c3d07ebe843a5cc7b8d70a934fe56e43318e3a0b56be4
    HEAD_REF master
)
file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)
vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
# Handle copyright
file(COPY ${SOURCE_PATH}/README.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/nativefiledialog/)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/nativefiledialog RENAME copyright)