project(libmsr C)
cmake_minimum_required(VERSION 3.0)

# Force default build type to be RelWithDebInfo
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "RelWithDebInfo" CACHE STRING "Choose the type of build, options are: Debug Release RelWithDebInfo." FORCE)
endif()

# Build helpers
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

# Build autoconf utility
set(sources ${PROJECT_SOURCE_DIR}/autoconf.c)
add_executable(autoconf ${sources})
set(AUTOCONF _autoconf_)
set_target_properties(autoconf PROPERTIES OUTPUT_NAME ${AUTOCONF})    

# Execute autoconf
set(LIBMSR_TARGET_ARCH "" CACHE STRING "Force configuring for a particular architecture")
if (LIBMSR_TARGET_ARCH)
    add_custom_target(autoconf_command
        COMMAND autoconf -d ${PROJECT_SOURCE_DIR} -o ${PROJECT_BINARY_DIR} -f ${LIBMSR_TARGET_ARCH}
        DEPENDS autoconf
        WORKING_DIRECTORY ${PROJECT_BINARY_DIR})
else()
    add_custom_target(autoconf_command
        COMMAND autoconf -d ${PROJECT_SOURCE_DIR} -o ${PROJECT_BINARY_DIR}
        DEPENDS autoconf
        WORKING_DIRECTORY ${PROJECT_BINARY_DIR})
endif()

# Add subdirectories
add_subdirectory(include)
add_subdirectory(src)
add_subdirectory(dox)

add_subdirectory(test)
add_subdirectory(msrmod)
add_subdirectory(demoapps/powmon)

# Export targets
install(EXPORT msrTargets
        FILE msrTargets.cmake
        NAMESPACE msr::
        DESTINATION ${CMAKE_INSTALL_PREFIX}/cmake/msr)