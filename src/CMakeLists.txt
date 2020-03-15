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
    msr_turbo.c)

# Create an interface library for HWLOC
add_library(msr SHARED ${sources})
add_library(msr-static STATIC ${sources})

# Add public headers to the libraries
set_target_properties(msr msr-static PROPERTIES
    PUBLIC_HEADER "${BUILD_HEADERS}")

# Add dynamic library
target_link_libraries(msr
    PRIVATE msr-hwloc)
target_include_directories(msr 
    PUBLIC 
        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include>)
add_dependencies(msr autoconf_command)

# Add static library
target_link_libraries(msr-static
    PRIVATE msr-hwloc)
target_include_directories(msr-static 
    PUBLIC 
        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include>)
set_target_properties(msr-static PROPERTIES OUTPUT_NAME msr)
add_dependencies(msr-static autoconf_command)

# Add libraries to the export target
install(
    TARGETS msr msr-static msr-hwloc
    EXPORT msrTargets)