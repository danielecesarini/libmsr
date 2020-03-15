set(POWMON_SOURCES
    highlander.c
    powmon.c
    rapl2.c)
set(POWER_WRAPPER_STATIC_SOURCES
    highlander.c
    power_wrapper_static.c
    rapl2.c)
set(POWER_WRAPPER_DYNAMIC_SOURCES
    highlander.c
    power_wrapper_dynamic.c
    rapl2.c)

# Dependencies
find_package(Threads REQUIRED)

# Executables
add_executable(powmon ${POWMON_SOURCES})
add_executable(power_wrapper_static ${POWER_WRAPPER_STATIC_SOURCES})
add_executable(power_wrapper_dynamic ${POWER_WRAPPER_DYNAMIC_SOURCES})

target_link_libraries(powmon PRIVATE msr Threads::Threads)
target_link_libraries(power_wrapper_static PRIVATE msr Threads::Threads)
target_link_libraries(power_wrapper_dynamic PRIVATE msr Threads::Threads m)

target_include_directories(powmon PRIVATE ${PROJECT_SOURCE_DIR}/include)
target_include_directories(power_wrapper_static PRIVATE ${PROJECT_SOURCE_DIR}/include)
target_include_directories(power_wrapper_dynamic PRIVATE ${PROJECT_SOURCE_DIR}/include)

# Add rpath to libmsr
set_target_properties(powmon power_wrapper_static power_wrapper_dynamic
    PROPERTIES
        INSTALL_RPATH "$ORIGIN/../lib")

# Install binaries
install(TARGETS powmon power_wrapper_static power_wrapper_dynamic
    RUNTIME DESTINATION demo)