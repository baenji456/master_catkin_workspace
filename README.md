# Docker:

1) [LADYBUG SDK](https://www.flir.com/support-center/iis/machine-vision/downloads/ladybug-sdk-and-firmware/ladybug-sdk--download-files/) herunterladen (Ubuntu 20.04)

2) Entpacken nach install_ladybug (evtl Ordnerpfad in Dockerfile anpassen)

3) docker build -t benni_capture_sys .

4) docker compose up

## Im Container

1) source /opt/ros/noetic/setup.bash
2) catkin build
