cmake_minimum_required(VERSION 3.0.2)
project(master)



find_package(catkin REQUIRED COMPONENTS
	roscpp
	std_msgs
	message_generation
	tf
	cv_bridge
)

find_package(Eigen3 REQUIRED)
find_package(PCL REQUIRED COMPONENTS common)
find_package(tf2_eigen REQUIRED)
find_package(CURL REQUIRED)
find_package(Boost REQUIRED)
#find_package(GL REQUIRED)

find_package(
  catkin REQUIRED
  COMPONENTS sensor_msgs
             geometry_msgs
             pcl_conversions
             tf2
             tf2_ros
             nodelet)

set(CMAKE_CXX_FLAGS "-std=c++11 -O3 -Wall -g ${CMAKE_CXX_FLAGS} -lGL -lGLU -lglut")

find_package(OpenCV REQUIRED)

catkin_package()

if(EXISTS "/usr/include/ladybug")
	include_directories(
		/usr/include/ladybug
		src/
		${catkin_INCLUDE_DIRS}
		${OpenCV_INCLUDE_DIRS}
	)
  add_executable(record_pgr src/Record_PGR.cpp)
	target_link_libraries(record_pgr
		${catkin_LIBRARIES}
		${OpenCV_LIBS}
		flycapture
		ladybug
	)
else()
	message("'SDK for Ladybug' is not installed. 'record_pgr' will not be built.")
endif()



include_directories(include ${catkin_INCLUDE_DIRS})

catkin_install_python(PROGRAMS scripts/record_pcap.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)


target_link_libraries(record_pgr ${catkin_LIBRARIES})
#add_dependencies(record_pgr master_record_pgr_cpp)