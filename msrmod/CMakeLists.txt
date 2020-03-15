add_executable(msrmod msrmod.c)
target_link_libraries(msrmod PRIVATE msr m)

# Add rpath to libmsr
set_target_properties(msrmod
    PROPERTIES
        INSTALL_RPATH "$ORIGIN/../lib")

# Install binaries
install(TARGETS msrmod)