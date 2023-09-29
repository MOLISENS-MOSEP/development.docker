FROM ros:humble

SHELL ["/bin/bash", "-o", "pipefail", "-c"]



# Define build arguments for host user's UID and GID
ARG HOST_UID
ARG HOST_GID

# Get the host user's username
ARG HOST_USER_NAME

# Create a user with the same UID and GID as the host user, and use the host user's primary group
RUN useradd -u $HOST_UID -g $HOST_GID -G sudo -m $HOST_USER_NAME && echo "$HOST_USER_NAME ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Switch to the non-${HOST_USER_NAME} user
USER $HOST_USER_NAME



RUN apt-get update && apt-get install -y \
    iputils-ping  \
    tmux \
    htop \
    nano \
    unzip \
    zip \
    git \
    gitk \
    net-tools \
    vim \
    sudo \
    cmake \
    chrony \
    libeigen3-dev \
    can-utils \
    rapidjson-dev \
    libboost-all-dev \
    qtbase5-dev \
    libqt5svg5-dev \
    qtdeclarative5-dev \
    qtmultimedia5-dev \
    libqt5multimedia5-plugins \
    libfmt-dev \
    libnl-genl-3-dev \
    sysstat \
    libasio-dev \
    libjsoncpp-dev \
    libpcl-dev \
    tcpreplay \
    libasio-dev \
    libtclap-dev \
    libcgal-dev \
    libapr1-dev \
    gedit \
    p7zip-full \
    p7zip-rar \
    wget \
    curl \
    nlohmann-json3-dev \
    libyaml-cpp-dev \
    libcrypto++-dev \
    libaprutil1-dev \
    apt-transport-https \
    libcpprest-dev \
    libpcap-dev \
    libglfw3-dev


RUN apt-get update && apt-get install -y \
    ros-$ROS_DISTRO-rviz2 \
    ros-$ROS_DISTRO-image-tools \
    ros-$ROS_DISTRO-rqt-image-view \
    ros-$ROS_DISTRO-image-geometry \
    ros-$ROS_DISTRO-camera-calibration-parsers \
    ros-$ROS_DISTRO-camera-info-manager \
    ros-$ROS_DISTRO-compressed-depth-image-transport \
    ros-$ROS_DISTRO-compressed-image-transport \
    ros-$ROS_DISTRO-theora-image-transport



RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /home/${HOST_USER_NAME}/ros_ws/install/setup.bash" >> ~/.bashrc

RUN echo "export ROS_DOMAIN_ID=31" >> ~/.bashrc

# This is meant to keep the container running even if no one is attached
CMD ["/bin/sh", "-c", "trap 'exit 147' TERM; tail -f /dev/null & wait ${!}"]

