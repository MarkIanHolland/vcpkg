include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO lighthouse3d/VSL
    REF fe7b9ad925c6cee7c93cee9fb98695417e01da46
    SHA512 b48f66fac4d345bdfe7f4e85d0f8530e1aca42158edb6632dff9259ce7c00b055a72bbff48e816c427b7badc6ae825222097c659c84449412197fb8c5ea86a11
    HEAD_REF master
    PATCHES consume-vcpkg.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/vsl
    PREFER_NINJA
    OPTIONS
        -DWINDOWS_EXPORT_ALL_SYMBOLS=ON
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
configure_file(${SOURCE_PATH}/LICENSE ${CURRENT_PACKAGES_DIR}/share/vsl/copyright COPYONLY)