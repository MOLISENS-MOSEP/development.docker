#!/bin/bash

PLATFORM=$(uname -i)
ROS_DISTRO="humble"

docker run -it --net=host --privileged \
--device /dev/video0 \
-v /opt/vc:/opt/vc \
--env LD_LIBRARY_PATH=/opt/vc/lib \
-v /home/$USER/projects/MOLISENS/camera_ws:/home/$USER/camera_ws \
registry-gitlab.v2c2.at/molisens/development/docker/camera_$ROS_DISTRO:$PLATFORM /bin/bash