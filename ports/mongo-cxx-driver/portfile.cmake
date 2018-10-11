include(vcpkg_common_functions)
vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
    REPO mongodb/mongo-cxx-driver
	REF r3.3.1
    SHA512 ca82aedd60df722f3a560bfede73a67770f46cd88994c1e1c40c2b26c4dfc027652b6b37f3dddccf78c242f05bc34285b9c54432aea6343dc46881b534f5ae36
	HEAD_REF master
	PATCHES
	 "${CURRENT_PORT_DIR}/disable_test_and_example.patch"
	 "${CURRENT_PORT_DIR}/disable_shared.patch"
	 "${CURRENT_PORT_DIR}/fix-uwp.patch"
	 "${CURRENT_PORT_DIR}/disable-c2338-mongo-cxx-driver.patch"
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS
        -DLIBBSON_DIR=${CURRENT_INSTALLED_DIR}
        -DLIBMONGOC_DIR=${CURRENT_INSTALLED_DIR}
)

vcpkg_install_cmake()

file(RENAME
    ${CURRENT_PACKAGES_DIR}/include/bsoncxx/v_noabi/bsoncxx
    ${CURRENT_PACKAGES_DIR}/temp)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/bsoncxx)
file(RENAME ${CURRENT_PACKAGES_DIR}/temp ${CURRENT_PACKAGES_DIR}/include/bsoncxx)

file(RENAME
    ${CURRENT_PACKAGES_DIR}/include/mongocxx/v_noabi/mongocxx
    ${CURRENT_PACKAGES_DIR}/temp)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/mongocxx)
file(RENAME ${CURRENT_PACKAGES_DIR}/temp ${CURRENT_PACKAGES_DIR}/include/mongocxx)

file(REMOVE_RECURSE
    ${CURRENT_PACKAGES_DIR}/lib/cmake
    ${CURRENT_PACKAGES_DIR}/debug/lib/cmake

    ${CURRENT_PACKAGES_DIR}/include/bsoncxx/cmake
    ${CURRENT_PACKAGES_DIR}/include/bsoncxx/config/private
    ${CURRENT_PACKAGES_DIR}/include/bsoncxx/private
    ${CURRENT_PACKAGES_DIR}/include/bsoncxx/test
    ${CURRENT_PACKAGES_DIR}/include/bsoncxx/third_party

    ${CURRENT_PACKAGES_DIR}/include/mongocxx/cmake
    ${CURRENT_PACKAGES_DIR}/include/mongocxx/config/private
    ${CURRENT_PACKAGES_DIR}/include/mongocxx/test
    ${CURRENT_PACKAGES_DIR}/include/mongocxx/test_util
    ${CURRENT_PACKAGES_DIR}/include/mongocxx/private
    ${CURRENT_PACKAGES_DIR}/include/mongocxx/exception/private
    ${CURRENT_PACKAGES_DIR}/include/mongocxx/options/private

    ${CURRENT_PACKAGES_DIR}/debug/include)


if (VCPKG_LIBRARY_LINKAGE STREQUAL static)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/bin)
    file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin)
    file(REMOVE         ${CURRENT_PACKAGES_DIR}/lib/bsoncxx.lib)
    file(REMOVE         ${CURRENT_PACKAGES_DIR}/debug/lib/bsoncxx.lib)
    file(REMOVE         ${CURRENT_PACKAGES_DIR}/lib/mongocxx.lib)
    file(REMOVE         ${CURRENT_PACKAGES_DIR}/debug/lib/mongocxx.lib)

    file(RENAME
        ${CURRENT_PACKAGES_DIR}/lib/libbsoncxx.lib
        ${CURRENT_PACKAGES_DIR}/lib/bsoncxx.lib)
    file(RENAME
        ${CURRENT_PACKAGES_DIR}/debug/lib/libmongocxx.lib
        ${CURRENT_PACKAGES_DIR}/debug/lib/mongocxx.lib)

    # define MONGOCXX_STATIC in config/export.hpp
    vcpkg_apply_patches(
        SOURCE_PATH ${CURRENT_PACKAGES_DIR}/include
        PATCHES
            ${CMAKE_CURRENT_LIST_DIR}/static.patch
    )
else()
    file(REMOVE         ${CURRENT_PACKAGES_DIR}/lib/libbsoncxx.lib)
    file(REMOVE         ${CURRENT_PACKAGES_DIR}/debug/lib/libbsoncxx.lib)
    file(REMOVE         ${CURRENT_PACKAGES_DIR}/lib/libmongocxx.lib)
    file(REMOVE         ${CURRENT_PACKAGES_DIR}/debug/lib/libmongocxx.lib)
endif()

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/mongo-cxx-driver RENAME copyright)
file(COPY ${SOURCE_PATH}/THIRD-PARTY-NOTICES DESTINATION ${CURRENT_PACKAGES_DIR}/share/mongo-cxx-driver)

vcpkg_copy_pdbs()