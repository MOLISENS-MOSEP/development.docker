#!/bin/bash

version="v1.0.0"
PLATFORM=$(uname -i)


docker build \
    --rm \
    --network=host \
    --tag registry-gitlab.v2c2.at/molisens/development/docker/ouster_ros1:$PLATFORM \
    --file Dockerfile .


#docker push registry-gitlab.v2c2.at/molisens/development/docker/ouster_ros1:$PLATFORM

