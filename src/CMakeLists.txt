file(GLOB chipmunk_source_files "*.c")
file(GLOB chipmunk_public_header "${chipmunk_SOURCE_DIR}/include/chipmunk/*.h")

include_directories(${chipmunk_SOURCE_DIR}/include)

set(CHIPMUNK_VERSION_MAJOR 7)
set(CHIPMUNK_VERSION_MINOR 0)
set(CHIPMUNK_VERSION_PATCH 0)
set(CHIPMUNK_VERSION "${CHIPMUNK_VERSION_MAJOR}.${CHIPMUNK_VERSION_MINOR}.${CHIPMUNK_VERSION_PATCH}")
message("Configuring Chipmunk2D version ${CHIPMUNK_VERSION}")

if(NOT CHIPMUNK_PREFIX)
  set(CHIPMUNK_PREFIX chipmunk)
endif(NOT CHIPMUNK_PREFIX)

if(NOT CHIPMUNK_TARGET_LIBRARY_SHARED)
  set(CHIPMUNK_TARGET_LIBRARY_SHARED ${CHIPMUNK_PREFIX})
endif(NOT CHIPMUNK_TARGET_LIBRARY_SHARED)

if(NOT CHIPMUNK_TARGET_LIBRARY_STATIC)
  set(CHIPMUNK_TARGET_LIBRARY_STATIC ${CHIPMUNK_PREFIX}_static)
endif(NOT CHIPMUNK_TARGET_LIBRARY_STATIC)

if(BUILD_SHARED)
  add_library(${CHIPMUNK_TARGET_LIBRARY_SHARED} SHARED
    ${chipmunk_source_files}
  )
  # Tell MSVC to compile the code as C++.
  if(MSVC)
    set_source_files_properties(${chipmunk_source_files} PROPERTIES LANGUAGE CXX)
    set_target_properties(${CHIPMUNK_TARGET_LIBRARY_SHARED} PROPERTIES LINKER_LANGUAGE CXX)
  endif(MSVC)
  # set the lib's version number
  # But avoid on Android because symlinks to version numbered .so's don't work with Android's Java-side loadLibrary.
  if(NOT ANDROID)
    set_target_properties(${CHIPMUNK_TARGET_LIBRARY_SHARED} PROPERTIES
      SOVERSION ${CHIPMUNK_VERSION_MAJOR}
      VERSION ${CHIPMUNK_VERSION})
  endif(NOT ANDROID)
  if(ANDROID OR UNIX)
    # need to explicitly link to the math library because the CMake/Android toolchains may not do it automatically
    target_link_libraries(${CHIPMUNK_TARGET_LIBRARY_SHARED} m)
  endif(ANDROID OR UNIX)
  install(TARGETS ${CHIPMUNK_TARGET_LIBRARY_SHARED} RUNTIME DESTINATION ${BIN_INSTALL_DIR}
                           LIBRARY DESTINATION ${LIB_INSTALL_DIR}
                           ARCHIVE DESTINATION ${LIB_INSTALL_DIR})
endif(BUILD_SHARED)

if(BUILD_STATIC)
  add_library(${CHIPMUNK_TARGET_LIBRARY_STATIC} STATIC
    ${chipmunk_source_files}
  )
  # Tell MSVC to compile the code as C++.
  if(MSVC)
    set_source_files_properties(${chipmunk_source_files} PROPERTIES LANGUAGE CXX)
    set_target_properties(${CHIPMUNK_TARGET_LIBRARY_STATIC} PROPERTIES LINKER_LANGUAGE CXX)
  endif(MSVC)
  # Sets chipmunk_static to output "libchipmunk.a" not "libchipmunk_static.a"
  set_target_properties(${CHIPMUNK_TARGET_LIBRARY_STATIC} PROPERTIES OUTPUT_NAME chipmunk)
  if(INSTALL_STATIC)
    install(TARGETS ${CHIPMUNK_TARGET_LIBRARY_STATIC} ARCHIVE DESTINATION ${LIB_INSTALL_DIR})
  endif(INSTALL_STATIC)
endif(BUILD_STATIC)

if(BUILD_SHARED OR INSTALL_STATIC)
  # FIXME: change to PUBLIC_HEADER to allow building frameworks
  install(FILES ${chipmunk_public_header} DESTINATION include/chipmunk)
  install(FILES ${chipmunk_constraint_header} DESTINATION include/chipmunk/constraints)
endif(BUILD_SHARED OR INSTALL_STATIC)
