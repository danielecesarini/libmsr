add_executable(msrmod msrmod.c)
target_link_libraries(msrmod PRIVATE msr m)

# Install binaries
install(TARGETS msrmod)