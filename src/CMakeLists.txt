# Static and dynamic libs have the same sources, so make a variable.
set(sources
    cpuid.c
    csr_core.c
    csr_imc.c
    memhdlr.c
    libmsr_error.c
    msr_clocks.c
    msr_core.c
    msr_counters.c
    msr_misc.c
    msr_rapl.c
    msr_thermal.c
    msr_turbo.c
)

# Dependencies
find_package(HWLOC)
if(HWLOC_FOUND)
    add_library(msr-hwloc INTERFACE)
    target_link_libraries(msr-hwloc INTERFACE ${HWLOC_LIBRARY})
    target_include_directories(msr-hwloc INTERFACE ${HWLOC_INCLUDE_DIRS})
else()
    MESSAGE(FATAL_ERROR "Hwloc support needed")
endif()

# Add dynamic library
add_library(msr ${sources})
target_link_libraries(msr
    PRIVATE msr-hwloc m
)
target_include_directories(msr 
    PUBLIC 
        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include>)
add_dependencies(msr autoconf_command)

# Install library
install(
    TARGETS msr msr-hwloc
    EXPORT msrTargets
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})