/**
 * This file defines all helper functions.
 * Those functions shouldn't depend on any thing in this project
 */
#pragma once
#ifndef _CALLBACKS_H_
#define _CALLBACKS_H_

#include "common.h"
#include "helper.h"
#include "trackball.h"
#include "meshwrapper.h"

// Global Variables
namespace otv 
{
    // window size
    extern unsigned int WINX, WINY;
    extern ospcommon::vec2i WINSIZE;

    // texture maps
    extern uint32_t*          ofb;
    extern cyGLRenderBuffer2D gfb;

    // OSPRay objects
    extern OSPModel       world;
    extern OSPCamera      camera;
    extern OSPRenderer    renderer;
    extern OSPFrameBuffer framebuffer;

    // camera objects
    extern float camZoom;
    extern ospcommon::vec3f camFocus;
    extern ospcommon::vec3f camPos;
    extern ospcommon::vec3f camUp;
    extern ospcommon::vec3f camDir;
    extern Trackball camRotate;

    // mesh
    extern Mesh mesh;
};

namespace otv 
{
    void KeyboardAction(int key, int x, int y);

    void UpdateCamera(bool cleanbuffer = true);

    void GetMouseButton(GLint button, GLint state, GLint x, GLint y);
    void GetMousePosition(GLint x, GLint y);

    void GetNormalKeys(unsigned char key, GLint x, GLint y);
    void GetSpecialKeys(int key, GLint x, GLint y);

    void Clean();

    inline void Idle() { glutPostRedisplay(); }
};

#endif//_CALLBACKS_H_