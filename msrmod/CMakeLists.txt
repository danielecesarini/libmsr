add_executable (msrmod msrmod.c)
target_link_libraries (msrmod PRIVATE msr m)

# Install binaries
install(
    TARGETS msrmod
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})