@echo off
setlocal enabledelayedexpansion

REM Check the argument passed to the script
if "%1"=="release" (
    set BUILD_TYPE=Release
) else (
    set BUILD_TYPE=Debug
)

REM Run CMake to configure and build
cmake -S . -B build -DCMAKE_BUILD_TYPE=!BUILD_TYPE!
cmake --build build --config !BUILD_TYPE!

REM Run the executable
build\!BUILD_TYPE!\voxel-engine.exe