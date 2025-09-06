#pragma once
#include "header.h"

/*
Camera class
holds all related variables, all public for now
creates view matrix
*/

class Camera {
 public:
  glm::vec3 pos;        // Location of camera in world space
  glm::vec3 lookDir;    // Direction vector along the direction camera points
  float fYaw = 0.0f;    // FPS Camera rotation in XZ plane
  float fPitch = 0.0f;  // FPS Camera rotation in YZ plane

  Camera() = default;
  Camera(glm::vec3 pos) : pos(pos) {
    // look at z by default
    lookDir = {0, 0, 1};
  }

  glm::mat4 viewMatrix() {
    // Calculate the forward vector from yaw and pitch angles
    glm::vec3 forward;
    forward.x = cos(fPitch) * sin(fYaw);
    forward.y = sin(fPitch);
    forward.z = cos(fPitch) * cos(fYaw);

    // Normalize the forward vector to get the look direction
    lookDir = glm::normalize(forward);

    // Define the up vector (world up direction)
    glm::vec3 up = {0.0f, 1.0f, 0.0f};

    // Calculate the right vector
    glm::vec3 right = glm::normalize(glm::cross(up, lookDir));

    // Recalculate the orthogonal up vector
    up = glm::cross(lookDir, right);

    // Calculate the target point the camera is looking at
    glm::vec3 target = pos + lookDir;

    // Create and return the view matrix using glm::lookAt
    return glm::lookAt(pos, target, up);
  }
};
