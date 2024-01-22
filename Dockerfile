# Verwende das offizielle ROS-Basisimage
FROM ros:noetic

# Setze das Arbeitsverzeichnis im Container
WORKDIR /catkin_ws

# Kopiere den Catkin-Workspace in das Image
COPY . /catkin_ws

# Installiere Abhängigkeiten
RUN apt-get update && apt-get install -y \
    ros-noetic-catkin \
    && rm -rf /var/lib/apt/lists/*

# Baue den Catkin-Workspace
# RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && catkin_make"

# Setze den Startbefehl für den Container
CMD ["bash"]