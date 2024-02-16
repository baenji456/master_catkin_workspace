# Verwende das offizielle ROS-Basisimage
FROM ros:noetic

# create a non-root user
ARG USER_NAME="benni"
ARG USER_ID="1004"

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



RUN useradd -m --no-log-init --system  --uid ${USER_ID} ${USER_NAME} -g sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# create home directory for user
RUN mkdir -p /home/${USER_NAME}
COPY . /home/${USER_NAME}/catkin_ws
WORKDIR /home/${USER_NAME}/catkin_ws
RUN rm -rf build
RUN rm -rf devel

RUN bash /home/${USER_NAME}/catkin_ws/install_ladybug/ladybug-1.19.0.13-amd64/install_ladybug.sh

# manually configure the USB-FS memory
COPY rc.local /etc/rc.local
RUN chmod 744 /etc/rc.local

#create symbolic links for linker
RUN ln -s /usr/lib/ladybug/libladybug.so /usr/lib/libladybug.so
RUN ln -s /usr/lib/ladybug/libflycapture.so /usr/lib/libflycapture.so

# ladybug needs Documents folder to create context
RUN mkdir /root/Documents

RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.profile
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN echo "source /home/${USER_NAME}/catkin_ws/devel/setup.bash" >> ~/.profile
RUN echo "source /home/${USER_NAME}/catkin_ws/devel/setup.bash" >> ~/.bashrc
RUN echo "echo "ros 1 noetic sourced"" >> ~/.profile
RUN echo "echo "ros 1 noetic sourced"" >> ~/.bashrc

# setup entrypoint
COPY ros_entrypoint.sh /home/${USER_NAME}/catkin_ws/
RUN chmod +x /home/${USER_NAME}/catkin_ws/ros_entrypoint.sh
ENTRYPOINT /home/benni/catkin_ws/ros_entrypoint.sh

RUN chmod +x /home/${USER_NAME}/catkin_ws/src/master/src/Record_PGR.cpp
