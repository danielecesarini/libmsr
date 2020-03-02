# First check for user-specified HWLOC_DIR
if(HWLOC_DIR)
    set(HWLOC_INCLUDE_DIR ${HWLOC_DIR}/include)
    set(HWLOC_LIBRARIES_DIR ${HWLOC_DIR}/lib)

    find_library(HWLOC_LIBRARIES
        NAMES hwloc
        PATHS ${HWLOC_INCLUDE_DIR}
    )

    find_path(HWLOC_INCLUDE_DIRS
        NAMES hwloc.h
        PATHS ${HWLOC_LIBRARIES_DIR}
    )

    if(HWLOC_INCLUDE_DIRS AND HWLOC_LIBRARIES)
        set(HWLOC_FOUND TRUE)
        if(NOT HWLOC_FIND_QUIETLY)
            message(STATUS "Found HWLOC using HWLOC_DIR = ${HWLOC_DIR}")
            message(STATUS "  HWLOC_INCLUDE_DIRS = ${HWLOC_INCLUDE_DIRS}")
            message(STATUS "  HWLOC_LIBRARIES = ${HWLOC_LIBRARIES}")
        endif()
    else()
        set(HWLOC_FOUND FALSE)
    endif()
# If HWLOC_DIR not specified, then try to automatically find the HWLOC header
# and library
elseif(NOT HWLOC_DIR)
    # Try to find HWLOC using pkg-config
    find_package(PkgConfig QUIET)
    if(PkgConfig_FOUND)
         pkg_check_modules(HWLOC hwloc)
    endif()

    if(HWLOC_FOUND)
        set(HWLOC_LIBRARIES ${HWLOC_LDFLAGS})
        if(NOT HWLOC_FIND_QUIETLY)
            message(STATUS "Found HWLOC using pkg-config")
            message(STATUS "  HWLOC_INCLUDE_DIRS = ${HWLOC_INCLUDE_DIRS}")
            message(STATUS "  HWLOC_LIBRARIES = ${HWLOC_LIBRARIES}")
        endif()
    else()
        find_library(HWLOC_LIBRARIES
            NAMES hwloc
            PATHS ENV LD_LIBRARY_PATH
        )

        set(_extralibdirs)
        if(DEFINED $ENV{HWLOC_HOME})
            list(APPEND _extralibdirs $ENV{HWLOC_HOME}/include)
        endif()
        if(DEFINED $ENV{HWLOC_ROOT})
            list(APPEND _extralibdirs $ENV{HWLOC_ROOT}/include)
        endif()
        if(DEFINED $ENV{HWLOC_PATH})
            list(APPEND _extralibdirs $ENV{HWLOC_PATH}/include)
        endif()
        if(DEFINED $ENV{HWLOC_DIR})
            list(APPEND _extralibdirs $ENV{HWLOC_DIR}/include)
        endif()
        if(HWLOC_LIBRARIES)
            get_filename_component(_hwloc_lib "${HWLOC_LIBRARIES}" PATH)
            get_filename_component(_hwloc "${_hwloc_lib}" PATH)
            list(APPEND _extralibdirs ${_hwloc}/include)
        endif()

        find_path(HWLOC_INCLUDE_DIRS
            NAMES hwloc.h
            PATHS _extralibdirs
        )

        if(HWLOC_INCLUDE_DIRS AND HWLOC_LIBRARIES)
            set(HWLOC_FOUND TRUE)
            if(NOT HWLOC_FIND_QUIETLY)
                message(STATUS "Found HWLOC library using find_library()")
                message(STATUS "  HWLOC_INCLUDE_DIRS = ${HWLOC_INCLUDE_DIRS}")
                message(STATUS "  HWLOC_LIBRARIES = ${HWLOC_LIBRARIES}")
            endif()
        endif()
    endif()
endif()

# If HWLOC is still not found
if(NOT HWLOC_FOUND)
    if(HWLOC_FIND_REQUIRED)
        message(FATAL_ERROR "HWLOC not Found!")
    else()
        if(NOT HWLOC_FIND_QUIETLY)
            message(WARNING "HWLOC not Found!")
        endif()
    endif()
endif()