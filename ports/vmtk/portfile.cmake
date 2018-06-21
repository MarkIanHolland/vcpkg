include(vcpkg_common_functions)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO vmtk/vmtk
    REF 44032a8b162fc4eb593efd401a016ffd70dc2de3
    SHA512 202771d1d53084f0a48e473696f0b23417b7afb9d63ec376b0c1d75278cf8c9239c83b0bdcc8bb9709236d03ab430c20cd8f5ed016c27cd7a29c5a1642d54a54
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DVMTK_USE_SUPERBUILD=OFF
        #-USE_SYSTEM_ITK=ON
        #-USE_SYUSTEM_VTK=ON
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

# Handle copyright
file(COPY ${SOURCE_PATH}/README.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/vmtk/)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/vmtk RENAME copyright)