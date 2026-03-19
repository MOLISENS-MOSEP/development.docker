# MOLISENS/MOSEP Docker Images

Docker image definitions for the MOLISENS/MOSEP development environment. Builds multi-platform images (x86_64, aarch64) using a three-layer approach for efficient caching and rebuilds.

## Image Layers

| Layer            | Dockerfile                  | Description                                                    |
| ---------------- | --------------------------- | -------------------------------------------------------------- |
| **Base**         | `Dockerfile.1_base`         | ROS 2 Humble base with locale, timezone, sudo                  |
| **Dependencies** | `Dockerfile.2_dependencies` | System libraries, ROS packages, Python tools, build essentials |
| **MOLISENS**     | `Dockerfile.3_molisens`     | Git config, entrypoint                                         |

## Building

Set a GitHub personal access token (needed to pull private dependencies during the build):

```bash
export GITHUB_TOKEN=<your_token>
```

Then build all layers for the current platform:

```bash
./build.sh
```

The script auto-detects the platform (`x86_64` or `aarch64`) and builds all three layers sequentially. Final images are tagged as:

```
ghcr.io/molisens-mosep/humble-<arch>:<version>
```

## Platform Support

| Platform | Directory  | Image Tag            |
| -------- | ---------- | -------------------- |
| x86_64   | `x86_64/`  | `humble-x86_64:0.5`  |
| ARM64    | `aarch64/` | `humble-aarch64:0.5` |

The aarch64 configuration includes device passthrough for sensors (serial ports, IMU, GPS).

## Ouster ROS 1 Bridge

The `Ouster_ROS1/` directory contains a special hybrid image for bridging Ouster LiDAR data between ROS 1 (Noetic) and ROS 2 (Galactic) using `ros1_bridge`:

```bash
cd Ouster_ROS1
./build_ouster_ros1.sh
./run_ouster_ros1.sh
```

Bridges topics: `/lidar_top/points`, `/tf`, `/tf_static`.

## Structure

```
docker/
├── build.sh              # Master build script
├── x86_64/                   # x86_64 Dockerfiles + entrypoint
│   ├── Dockerfile.1_base
│   ├── Dockerfile.2_dependencies
│   ├── Dockerfile.3_molisens
│   ├── entrypoint
│   └── env.sh
├── aarch64/                  # ARM64 Dockerfiles + entrypoint
│   ├── Dockerfile.1_base
│   ├── Dockerfile.2_dependencies
│   ├── Dockerfile.3_molisens
│   ├── entrypoint
│   └── env.sh
└── Ouster_ROS1/              # ROS 1↔ROS 2 bridge for Ouster LiDAR
    ├── Dockerfile
    ├── build_ouster_ros1.sh
    ├── run_ouster_ros1.sh
    └── ros1_bridge.yaml
```
