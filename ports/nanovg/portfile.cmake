include(vcpkg_common_functions)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO memononen/nanovg
    REF f4069e6a1ad5da430fb0a9c57476d5ddc2ff89b2
    SHA512 5f2313be939478d40e52c74e3935cbae91277be5c0e466a6d303e8d80e7bf0781288cb319b2e8cec5c7d6fc991be16bec6e0f5228153895ff7fe3abdffe5320e
    HEAD_REF master
)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt DESTINATION ${SOURCE_PATH})

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
)
vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

configure_file(${SOURCE_PATH}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/nanovg/copyright COPYONLY)