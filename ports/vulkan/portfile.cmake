# Due to the complexity involved, this package doesn't install the Vulkan SDK.
# It instead verifies that Vulkan is installed.
# Other packages can depend on this package to declare a dependency on Vulkan.

#string(REPLACE "\\" "/" VSDK $ENV{VULKAN_SDK})
#set(ENV{VULKAN_SDK} ${VSDK})

find_package(VULKAN QUIET)
if(NOT VULKAN_FOUND)
    message(FATAL_ERROR "Could not find Vulkan SDK. Before continuing, please download and install Vulkan from:"
                        "\n    https://vulkan.lunarg.com/sdk/home\n")
endif()

#set(VULKAN_REQUIRED_VERSION "1.1.82.1")
#if (VULKAN_VERSION LESS 1)
#    message(FATAL_ERROR "Vuklan ${VULKAN_VERSION} but ${VULKAN_REQUIRED_VERSION} is required. Please download and install a more recent version from:"
#                        "\n    https://vulkan.lunarg.com/sdk/home\n")
#endif()

SET(VCPKG_POLICY_EMPTY_PACKAGE enabled)