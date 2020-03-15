set(_public_headers
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
file(COPY ${_public_headers} DESTINATION ${PROJECT_BINARY_DIR}/include)

# Add master.h to the public headers
set(_public_headers "${_public_headers};master.h")

# Add building path to all public headers
set(_build_headers)
foreach(header ${_public_headers})
    list(APPEND _build_headers "${PROJECT_BINARY_DIR}/include/${header}")
endforeach()

# Set the global variable
set(BUILD_HEADERS "${_build_headers}" PARENT_SCOPE)