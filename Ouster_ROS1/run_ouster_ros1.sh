#!/bin/bash

PLATFORM=$(uname -i)

docker run -it --net=host --privileged registry-gitlab.v2c2.at/molisens/development/docker/ouster_ros1:$PLATFORM /bin/bash

