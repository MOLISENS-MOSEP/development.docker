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






RUN bash -c 'mkdir -p /catkin2_ws/src '
COPY ouster_msgs /catkin2_ws/src/ouster_msgs
RUN git clone https://github.com/ros2/ros1_bridge /catkin2_ws/src/ros1_bridge

RUN bash -c ' source /opt/ros/galactic/setup.bash; \
              cd catkin2_ws; \
              colcon build --symlink-install --packages-skip ros1_bridge'



RUN bash -c 'mkdir -p /catkin_ws/src '
RUN git clone --recurse-submodules https://github.com/ouster-lidar/ouster-ros.git /catkin_ws/src/ouster-lidar
RUN bash -c 'cd /catkin_ws/src && ls'
RUN bash -c ' source /opt/ros/noetic/setup.bash; \
              cd catkin_ws; \
              catkin_make --cmake-args -DCMAKE_BUILD_TYPE=Release'



#RUN bash -c ' rm -r opt/ros/galactic/share/ros1_bridge;  '

#RUN bash -c ' source /opt/ros/noetic/setup.bash; \
#              source /opt/ros/galactic/setup.bash;  \
#              source /catkin_ws/devel/setup.bash;  \
#              source /catkin2_ws/install/setup.bash; \
#              colcon build --symlink-install --packages-select ros1_bridge --cmake-force-configure'


RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /catkin_ws/devel/setup.bash" >> ~/.bashrc

RUN echo "source /opt/ros/galactic/setup.bash" >> ~/.bashrc
RUN echo "source /catkin2_ws/install/setup.bash" >> ~/.bashrc

RUN echo "export ROS_DOMAIN_ID=31" >> ~/.bashrc



COPY ros1_bridge.yaml /catkin_ws/src/ouster-lidar/ros1_bridge.yaml
COPY lidar_top.launch /catkin_ws/src/ouster-lidar/ouster-ros/launch/lidar_top.launch





CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]

