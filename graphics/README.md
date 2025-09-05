> This task is relevant for the **voxel engine**


# CS Club Open Source Team Recruitment Technical Assessment: Graphics
> **YOU DON'T NEED TO COMPLETE ALL PARTS.** 
> Complete the parts that you think **best** reflect your skills (you can do them in any order).

## Building and Running

### Install 

run the update command to get all the libraries
Run from the home directory
```sh
git submodule update --init
```

Go to graphics folder

```sh
cd graphics
```

### Build Linux, Mac OS, MSYS (Windows)

```sh
./build.sh
```

### Build Windows - Visual Studio

```bat
.\build.bat
```

### Install

Refer to [**INSTALL.md**](./graphics/INSTALL.md) for any debug steps for installing libraries

## What you are Provided

You are given the basic engine and some template code.

<img src="assets/code.png" alt="Engine Code" width="600"/>

<br>
Using the following vertices in main.cpp generates a single triangle.

<img src="assets/triangle.png" alt="Simple Triangle" width="600"/>


## Task 1: Create a Cube
Replace the current triangle with a 3D cube.

**Hints**:
- A cube has 8 vertices and 12 triangles (2 per face)
- You'll need to modify the `vertices` and `indices` vectors in `main.cpp`
- Remember the vertex format: `x, y, z, r, g, b, brightness`
- Consider which vertices connect to form each face
- Think about triangle winding order (clockwise vs counter-clockwise)

## Task 2: Simple Collision Detection
Implement basic collision detection to prevent the camera from moving through objects.

**Hints**:
- Add a collision detection function that checks camera position against object boundaries
- Modify the camera movement code in the main game loop
- Consider using simple bounding boxes or sphere collision
- You might want to store object positions and sizes in a data structure
- Think about how to "push back" the camera when it hits something

## Task 3: Basic Game - Maze or Platformer
Create a simple game using your collision system. This doesn't need to be too complicated, its more to teach you how to work with the rendering and collision logic to actually create something.

**Examples**:
1. **Maze Game**: Create walls the player must navigate around
2. **Platform Game**: Add gravity, jumping, and platforms to jump on

**Hints**:
- Use multiple cubes/objects to create your game world
- For a maze: Create wall objects and use collision to prevent walking through them
- For a platformer: Implement gravity (downward acceleration) and ground collision
- Consider adding a simple goal system (reach a target location)
- You might want to create a level data structure to define object positions
- Think about game state management (win/lose conditions)

## Additional Challenges
Once you complete the main tasks, try these advanced features:
- Multiple objects with different properties
- Animation and movement of objects
- Sound effects
- More complex collision shapes
- Particle effects

## File Structure
- `src/main.cpp` - Main application and game loop
- `src/camera.h` - Camera class definition
- `src/render.h` - Rendering system
- `src/header.h` - Common includes and definitions
- `src/shaders/` - Vertex and fragment shaders
- `libs/` - External libraries (glfw, etc.)
- `build.sh` - Build script for macOS and Linux
- `build.bat` - Build script for Windows

