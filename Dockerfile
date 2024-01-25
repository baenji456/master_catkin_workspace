# Verwende das offizielle ROS-Basisimage
FROM ros:noetic

# Setze das Arbeitsverzeichnis im Container
WORKDIR /catkin_ws

# Kopiere den Catkin-Workspace in das Image
COPY . /catkin_ws

# install ros packages
RUN rm -fr /var/lib/apt/lists/*
# Installiere Abhängigkeiten
RUN apt-get update && apt-get install --fix-missing -y \
    libspdlog-dev \
    ros-noetic-tf2-eigen \
    curl \
    libboost-all-dev \
    ros-noetic-catkin \ 
    ros-noetic-tf \
    ros-noetic-cv-bridge \
    ros-noetic-pcl-ros \
    libeigen3-dev \
    python3-catkin-tools \
    python3-pip \
    tf \
    && rm -rf /var/lib/apt/lists/*

# Baue den Catkin-Workspace
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash"

# Setze den Startbefehl für den Container
CMD ["bash"]