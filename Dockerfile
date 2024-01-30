# Verwende das offizielle ROS-Basisimage
FROM ros:noetic

# Setze das Arbeitsverzeichnis im Container
WORKDIR /catkin_ws

# Kopiere den Catkin-Workspace in das Image
COPY . /catkin_ws

ENV DEBIAN_FRONTEND=noninteractive
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
    libxerces-c3.2 \
    libraw1394-11 \
    libc6 \
    libusb-1.0-0 \
    xsdcxx \
    wget \
    libavcodec58 \
    libavformat58 \
    libavutil56 \
    libswscale5 \
    libglu1-mesa \
    libomp5 \
    freeglut3 \
    freeglut3-dev \
    libglu1-mesa-dev \
    && rm -rf /var/lib/apt/lists/*

RUN bash install_ladybug/ladybug-1.20.0.78-amd64/install_ladybug.sh

#create symbolic links for linker
RUN ln -s /usr/lib/ladybug/libladybug.so /usr/lib/libladybug.so
RUN ln -s /usr/lib/ladybug/libflycapture.so /usr/lib/libflycapture.so

# Baue den Catkin-Workspace
#RUN source /opt/ros/noetic/setup.bash
#RUN catkin build


# Setze den Startbefehl für den Container
CMD ["bash"]