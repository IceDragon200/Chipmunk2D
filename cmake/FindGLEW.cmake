# From imageutilities
# https://gitorious.org/imageutilities
#
# - Try to find the GLEW library
# Once done this will define
#
#  GLEW_FOUND - system has GLEW
#  GLEW_INCLUDE_DIR - the GLEW include directory
#  GLEW_LIBRARIES - The libraries needed to use GLEW

if(GLEW_INCLUDE_DIR AND GLEW_LIBRARIES)
   set(GLEW_FOUND TRUE)
else(GLEW_INCLUDE_DIR AND GLEW_LIBRARIES)

FIND_PATH(GLEW_INCLUDE_DIR GL/glew.h
   /usr/include
   /usr/local/include
   $ENV{GLEWROOT}/include
   $ENV{GLEW_ROOT}/include
   $ENV{GLEW_DIR}/include
   $ENV{GLEW_DIR}/inc
   [HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\VisualStudio\\8.0\\Setup\\VC]/PlatformSDK/Include
)

FIND_LIBRARY(GLEW_LIBRARIES NAMES glew64 GLEW glew glew32
   PATHS
   /usr/lib
   /usr/lib64
   /usr/local/lib
   /usr/local/lib64
   $ENV{GLEWROOT}/lib
   $ENV{GLEW_ROOT}/lib
   $ENV{GLEW_DIR}/lib
   [HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\VisualStudio\\8.0\\Setup\\VC]/PlatformSDK/Lib
   DOC "glew library name"
)

if(GLEW_INCLUDE_DIR AND GLEW_LIBRARIES)
   set(GLEW_FOUND TRUE)
endif(GLEW_INCLUDE_DIR AND GLEW_LIBRARIES)


if(GLEW_FOUND)
   if(NOT GLEW_FIND_QUIETLY)
      message(STATUS "Found GLEW: ${GLEW_LIBRARIES}")
   endif(NOT GLEW_FIND_QUIETLY)
else(GLEW_FOUND)
   if(GLEW_FIND_REQUIRED)
      message(FATAL_ERROR "could NOT find glew")
   endif(GLEW_FIND_REQUIRED)
endif(GLEW_FOUND)

MARK_AS_ADVANCED(GLEW_INCLUDE_DIR GLEW_LIBRARIES)

endif(GLEW_INCLUDE_DIR AND GLEW_LIBRARIES)

#=======
#.rst:
# FindGLEW
# --------
#
# Find the OpenGL Extension Wrangler Library (GLEW)
#
# This module defines the following variables:
#
# ::
#
#   GLEW_INCLUDE_DIRS - include directories for GLEW
#   GLEW_LIBRARIES - libraries to link against GLEW
#   GLEW_FOUND - true if GLEW has been found and can be used

#=============================================================================
# Copyright 2012 Benjamin Eikel
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of CMake, substitute the full
#  License text for the above reference.)

find_path(GLEW_INCLUDE_DIR GL/glew.h)
find_library(GLEW_LIBRARY NAMES GLEW glew32 glew glew32s PATH_SUFFIXES lib64)

set(GLEW_INCLUDE_DIRS ${GLEW_INCLUDE_DIR})
set(GLEW_LIBRARIES ${GLEW_LIBRARY})

include(${CMAKE_CURRENT_LIST_DIR}/FindPackageHandleStandardArgs.cmake)
find_package_handle_standard_args(GLEW
                                  REQUIRED_VARS GLEW_INCLUDE_DIR GLEW_LIBRARY)

mark_as_advanced(GLEW_INCLUDE_DIR GLEW_LIBRARY)
