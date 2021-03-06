#
#--- Libraries Setups
#
# Modified based on the course project from EPFL ICG course that I have taken
# This is used for configure the environment with CMAKE
#
# Build configuration file for "Intro to Graphics"
# Copyright (C) 2014 - LGG EPFL
#
#--- To understand its content:
#   http://www.cmake.org/cmake/help/syntax.html
#   http://www.cmake.org/Wiki/CMake_Useful_Variables
#
#--- Interface
#   This module wil define two global variables
#--- This is how you show a status message in the build system
MESSAGE(STATUS "Interactive Computer Graphics - Loading Common Configuration")
#
# define macro
MACRO(DeployRepo SRC DEST)
  message(STATUS " -- Deploying: ${SRC} to ${DEST}")
  FOREACH(f ${SRC})
    FILE(COPY ${f} DESTINATION ${DEST})
  ENDFOREACH()
ENDMACRO(DeployRepo)
#
#
SET(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PROJECT_SOURCE_DIR}/cmake")
#
# Setting up compiler
INCLUDE(${PROJECT_SOURCE_DIR}/cmake/configcxx.cmake)
#
# Initialize library pathes and dll path
SET(COMMON_LIBS "") # those will be link for each project
SET(COMMON_DLLS "") # those files will be copyed to the executable folder
SET(COMMON_DEFINITIONS "")
#
# check win arch
SET(WIN_ARCH "")
IF(WIN32)
  IF (CMAKE_SIZEOF_VOID_P EQUAL 8)
    SET(WIN_ARCH /x64)
  ENDIF()
ENDIF()
#
#--- OPENGL
FIND_PACKAGE(OpenGL REQUIRED)
IF(OPENGL_FOUND)
  MESSAGE(STATUS " OPENGL found!  ${OPENGL_LIBRARIES}")
  INCLUDE_DIRECTORIES(${OPENGL_INCLUDE_DIR})
  LIST(APPEND COMMON_LIBS ${OPENGL_LIBRARIES})
  IF(OPENGL_GLU_FOUND)
    MESSAGE(STATUS " GLU found!")
  ELSE()
    MESSAGE(ERROR " GLU not found!")
  ENDIF()
ELSE()
  MESSAGE(ERROR " OPENGL not found!")
ENDIF()
#
#--- CMake extension to load GLUT
SET(GLUT_ROOT_PATH "${PROJECT_SOURCE_DIR}/external/freeglut")
INCLUDE(${PROJECT_SOURCE_DIR}/cmake/glut.cmake)
IF(GLUT_FOUND)
    INCLUDE_DIRECTORIES(${GLUT_INCLUDE_DIR})
    LIST(APPEND COMMON_LIBS ${GLUT_LIBRARIES})
    LIST(APPEND COMMON_DLLS ${GLUT_DLL})
ELSE()
    MESSAGE(FATAL_ERROR " GLUT not found!")
ENDIF()
#
#--- GLEW
SET(GLEW_ROOT_PATH "${PROJECT_SOURCE_DIR}/external/glew")
INCLUDE(${PROJECT_SOURCE_DIR}/cmake/glew.cmake)
IF(GLUT_FOUND)
    INCLUDE_DIRECTORIES(${GLEW_INCLUDE_DIR})
    LIST(APPEND COMMON_LIBS ${GLEW_LIBRARIES})
    LIST(APPEND COMMON_DLLS ${GLEW_DLL})
ELSE()
    MESSAGE(FATAL_ERROR " GLEW not found!")
ENDIF()
#
#--- ospray
#
FIND_PACKAGE(ospray REQUIRED)
INCLUDE_DIRECTORIES(${OSPRAY_INCLUDE_DIRS})
MESSAGE(STATUS "OSPRay Include: ${OSPRAY_INCLUDE_DIRS}")
MESSAGE(STATUS "OSPRay Libraries: ${OSPRAY_LIBRARIES}")
#
#--- add cyCodeBase (submodule)
#   https://github.com/cemyuksel/cyCodeBase.git
# INCLUDE_DIRECTORIES(${PROJECT_SOURCE_DIR}/external/cyCodeBase)
#
#--- lodePNG
#   http://lodev.org/lodepng/
ADD_SUBDIRECTORY(${PROJECT_SOURCE_DIR}/external/lodepng)
INCLUDE_DIRECTORIES(${LodePNG_INCLUDE_DIR})
LIST(APPEND COMMON_LIBS ${LodePNG_LIBRARIES})
#
#--- imgui
#
ADD_SUBDIRECTORY("${PROJECT_SOURCE_DIR}/external/imgui")
LIST(APPEND COMMON_LIBS imgui)
#
#--- tiny OBJ loader
#
INCLUDE_DIRECTORIES("${PROJECT_SOURCE_DIR}/external/tinyobjloader")
#
#--- glm
#
INCLUDE_DIRECTORIES("${PROJECT_SOURCE_DIR}/external/glm")
#
#--- image magick++
#
FIND_PACKAGE(ImageMagick COMPONENTS Magick++)
IF (IMAGEMAGICK_FOUND)
  ADD_DEFINITIONS(-DUSE_IMAGEMAGICK)
  INCLUDE_DIRECTORIES(
    ${ImageMagick_Magick++_INCLUDE_DIR}
    ${ImageMagick_Magick++_ARCH_INCLUDE_DIR}
    )
  SET(MAGICK_LIBRARIES ${ImageMagick_Magick++_LIBRARY})
  LIST(APPEND COMMON_LIBS ${MAGICK_LIBRARIES})
ELSE()
  MESSAGE(STATUS
    "ImageMagick not found. Texture loaders other than PPM & PNG are disabled."
    )
ENDIF()
#
#--- rapid JSON
#
INCLUDE_DIRECTORIES("${PROJECT_SOURCE_DIR}/external/rapidjson/include")
