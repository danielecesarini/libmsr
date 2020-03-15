find_package(Doxygen)
if(DOXYGEN_FOUND)
    set(DOXYGEN_GENERATE_LATEX YES)
    set(DOXYGEN_GENERATE_HTML YES)
    set(DOXYGEN_GENERATE_MAN NO)

    doxygen_add_docs(doxygen
        Doxyfile
        ${PROJECT_SOURCE_DIR}
        COMMENT "Generating API documentation with Doxygen"
    )
else()
    message("Doxygen need to be installed to generate the doxygen documentation")
endif(DOXYGEN_FOUND)