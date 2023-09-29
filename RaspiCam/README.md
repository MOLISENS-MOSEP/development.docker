## Docker commands
docker build --rm --tag=camera:latest --network=host --file Dockerfile .
docker run -it --net=host --privileged --device /dev/video0 -v /opt/vc:/opt/vc --env LD_LIBRARY_PATH=/opt/vc/lib -v /home/cam/projects/MOLISENS/ros_ws:/home/$USER/ros_ws camera:latest
docker exec -it ce bash


## Test setup:

ros2 run image_tools cam2image
ros2 run rqt_image_view rqt_image_view # Not yet working


## Run the node:

source /home/$USER/ros_ws/install/setup.bash # not necessary anymore
ros2 run v4l2_camera v4l2_camera_node --ros-args -p image_size:=[1920,1080]
