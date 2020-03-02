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

# Create an interface library for HWLOC
add_library(msr-hwloc INTERFACE)
add_library(msr SHARED ${sources})
add_library(msr-static STATIC ${sources})

# Add dynamic library
target_link_libraries(msr
    PRIVATE msr-hwloc m
)
target_include_directories(msr 
    PUBLIC 
        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include>)
add_dependencies(msr autoconf_command)

# Add static library
target_link_libraries(msr-static
    PRIVATE msr-hwloc m
)
target_include_directories(msr-static 
    PUBLIC 
        $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/include>
        $<INSTALL_INTERFACE:${CMAKE_INSTALL_PREFIX}/include>)
add_dependencies(msr-static autoconf_command)
set_target_properties(msr-static PROPERTIES OUTPUT_NAME msr)

# Add libraries to the export target
install(
    TARGETS msr msr-static msr-hwloc
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})