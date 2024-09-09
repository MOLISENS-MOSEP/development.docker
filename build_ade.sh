#!/bin/bash

set -e

# Default settings
ROS_DISTRO="humble"
IMAGE_NAME="ghcr.io/molisens-mosep/$ROS_DISTRO"
TAG_VERSION="0.3"

PLATFORM=$(uname -m)
if  [[ $PLATFORM == arm64 ]]; then
    PLATFORM=aarch64
fi
##### Base ################################################
TAG_PREFIX="base_"$PLATFORM
BASE=$IMAGE_NAME:$TAG_PREFIX

echo -e "\tROS distro: $ROS_DISTRO"
echo -e "\tImage: $BASE"

# Update base image of Dockerfile.base so we don't use an outdated one
docker pull ros:$ROS_DISTRO

docker build \
    --rm \
    --network=host \
    --tag $BASE \
    --build-arg ROS_DISTRO=$ROS_DISTRO \
    --file $PLATFORM/Dockerfile.1_base .

##### Dependencies #############################################
TAG_PREFIX="dependencies_"$PLATFORM

DOCKER_BASE=$IMAGE_NAME":base_"$PLATFORM
BASE=$IMAGE_NAME:$TAG_PREFIX

echo -e "\tBase: $DOCKER_BASE"
echo -e "\tImage: $BASE"

docker build \
    --rm \
    --network=host \
    --tag $BASE \
    --build-arg DOCKER_BASE=$DOCKER_BASE \
    --file $PLATFORM/Dockerfile.2_dependencies .


##### MOLISENS #############################################
TAG_PREFIX=$PLATFORM

DOCKER_BASE=$IMAGE_NAME":dependencies_"$PLATFORM
BASE=$IMAGE_NAME"-"$PLATFORM":"$TAG_VERSION

echo -e "\tBase: $DOCKER_BASE"
echo -e "\tImage: $BASE"

export GITHUB_TOKEN=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
DOCKER_BUILDKIT=1 docker build \
    --secret id=deploytoken,env=GITHUB_TOKEN \
    --progress=plain \
    --rm \
    --network=host \
    --tag $BASE \
    --build-arg DOCKER_BASE=$DOCKER_BASE \
    --file $PLATFORM/Dockerfile.3_molisens .
