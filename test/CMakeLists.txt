set(LIBMSR_TESTS
    power_unit_test
    libmsr_test
    pstate_test
    read_rapl_data
    translate_pkg_rapl_limit
    turbo_test
    libmsr_dump_data
    power_cap_test
)

foreach(TEST ${LIBMSR_TESTS})
    add_executable(${TEST} ${TEST}.c)
    target_link_libraries(${TEST} PRIVATE msr msr-static msr-hwloc m)

    # Install binaries
    install(
        TARGETS ${TEST}
        RUNTIME DESTINATION test)
endforeach()