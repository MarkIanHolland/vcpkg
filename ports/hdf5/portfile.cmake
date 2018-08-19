if(VCPKG_CMAKE_SYSTEM_NAME STREQUAL "WindowsStore")
    message(FATAL_ERROR "${PORT} does not currently support UWP")
endif()

include(vcpkg_common_functions)
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/CMake-hdf5-1.10.2/hdf5-1.10.2)
vcpkg_download_distfile(ARCHIVE
    URLS "https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.2/src/CMake-hdf5-1.10.2.zip"
    FILENAME "CMake-hdf5-1.10.2.zip"
    SHA512 6c96f68f9ae2179695e1760f40d91f162d7b796ab53dc402f3c60ba44a29a48b5e8ed82b550000ce1715ea587f825565f6b3d17bb106e0d72662a7d60da3f4a4
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_apply_patches(
    SOURCE_PATH ${SOURCE_PATH}
    PATCHES
        ${CMAKE_CURRENT_LIST_DIR}/use-szip-config.patch
        ${CMAKE_CURRENT_LIST_DIR}/disable-static-libs.patch
        ${CMAKE_CURRENT_LIST_DIR}/link-libraries-private.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" DISABLE_STATIC_LIBS)

if ("parallel" IN_LIST FEATURES)
    set(ENABLE_PARALLEL ON)
else()
    set(ENABLE_PARALLEL OFF)
endif()

if ("cpp" IN_LIST FEATURES)
    set(ENABLE_CPP ON)
else()
    set(ENABLE_CPP OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_TESTING=OFF
        -DDISABLE_STATIC_LIBS=${DISABLE_STATIC_LIBS}
        -DHDF5_BUILD_EXAMPLES=OFF
        -DHDF5_BUILD_TOOLS=OFF
        -DHDF5_BUILD_CPP_LIB=${ENABLE_CPP}
        -DHDF5_ENABLE_PARALLEL=${ENABLE_PARALLEL}
        -DHDF5_ENABLE_Z_LIB_SUPPORT=ON
        -DHDF5_ENABLE_SZIP_SUPPORT=ON
        -DHDF5_ENABLE_SZIP_ENCODING=ON
        -DHDF5_INSTALL_DATA_DIR=share/hdf5/data
        -DHDF5_INSTALL_CMAKE_DIR=share/hdf5
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(RENAME ${CURRENT_PACKAGES_DIR}/share/hdf5/data/COPYING ${CURRENT_PACKAGES_DIR}/share/hdf5/copyright)

vcpkg_fixup_cmake_targets(CONFIG_PATH share/hdf5)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
