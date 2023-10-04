#!/bin/bash

version="v1.0.0"
PLATFORM=$(uname -i)
ROS_DISTRO="humble"


docker build \
    --rm \
    --network=host \
    --tag registry-gitlab.v2c2.at/molisens/development/docker/camera_$ROS_DISTRO:$PLATFORM \
    --file Dockerfile .


#docker push registry-gitlab.v2c2.at/molisens/development/docker/camera_$ROS_DISTRO:$PLATFORM

