FROM ros:galactic-ros1-bridge

SHELL ["/bin/bash", "-o", "pipefail", "-c"]


RUN apt-get update && \
    apt install --no-install-recommends -y \
    build-essential \
    libeigen3-dev   \
    libjsoncpp-dev  \
    libspdlog-dev   \
    cmake \    
    ros-noetic-pcl-ros             \
    ros-noetic-tf2-geometry-msgs   \
    sudo


RUN bash -c 'mkdir -p /catkin_ws/src '
RUN git clone --recurse-submodules https://github.com/ouster-lidar/ouster-ros.git /catkin_ws/src/ouster-lidar


RUN bash -c 'cd /catkin_ws/src && ls'


RUN bash -c ' source /opt/ros/noetic/setup.bash; \
              cd catkin_ws; \
              catkin_make --cmake-args -DCMAKE_BUILD_TYPE=Release'



RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

RUN echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc


COPY ros1_bridge.yaml /catkin_ws/src/ouster-lidar/ros1_bridge.yaml
COPY lidar_top.launch /catkin_ws/src/ouster-lidar/ouster-ros/launch/lidar_top.launch

CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]

