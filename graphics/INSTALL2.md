# Voxel Engine

## Look at Tasks for Technical Assessment Details

### Debug Install Instructions


```
git submodule update --init
```

## Building and running

### Linux, Mac OS, MSYS (Windows)

```sh
./build.sh
```

### Windows - Visual Studio

```bat
.\build.bat
```

## Troubleshooting

#### Missing libraries error and ```libs/``` content missing:

Either increase Git's maximum download size, then try again.

```
git config --global http.postBuffer 104857600
git submodule update --init
```

Or manually clone libraries into their corresponding ``libs/`` folder.


#### Missing libraries Ubuntu

In Ubuntu, install all the required packages with:

``` 
sudo apt update
sudo apt install libwayland-dev libxkbcommon-dev libx11-dev libxrandr-dev libxinerama-dev libxcursor-dev libxi-dev mesa-common-dev libgl1-mesa-dev
```

## Contributing

Our voxel engine is currently a work-in-progress, but we still welcome contributions. If you find any issues, have suggestions, or want to request a feature, please follow our [Contributing Guidelines](https://github.com/compsci-adl/.github/blob/main/CONTRIBUTING.md).

## License

This project is licensed under the MIT License.
See [LICENSE](LICENSE) for details.
