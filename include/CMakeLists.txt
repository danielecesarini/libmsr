set(header_sources
    csr_imc.h
    csr_core.h
    cpuid.h
    msr_turbo.h
    msr_thermal.h
    msr_rapl.h
    msr_misc.h
    msr_counters.h
    msr_core.h
    msr_clocks.h
    memhdlr.h
    libmsr_error.h
    libmsr_debug.h
)

# Copy all public headers in the build directory
file(COPY ${header_sources} DESTINATION ${PROJECT_BINARY_DIR}/include)

# Add master.h to the public headers
set(header_sources "${header_sources};master.h")

# Add building path to all public headers
foreach(header ${header_sources})
    set(build_headers ${build_headers};${PROJECT_BINARY_DIR}/include/${header})
endforeach()

# Create an interface library to install the public headers
add_library(msr_headers INTERFACE)
set_target_properties(msr_headers
    PROPERTIES
        PUBLIC_HEADER 
            "${build_headers}")

# Add public headers to the export target
install(
    TARGETS msr_headers
    EXPORT msrTargets
    PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_PREFIX}/include)