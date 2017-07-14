#pragma once
#ifndef _GLOBAL_H_
#define _GLOBAL_H_

#include "common/helper.h"
#include "loader/meshwrapper.h"
#include "ospray/world.h"

// Global Variables
namespace otv 
{
  // objects
  extern World world;  
  extern Mesh mesh;
  // flags 
  extern bool NOWIN_FLAG;
  // parameters
  extern int   WINX, WINY;
  extern vec2i WINSIZE;

};

#endif//_GLOBAL_H_