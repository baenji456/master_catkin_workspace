# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/benni/catkin_ws/src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/benni/catkin_ws/build

# Utility rule file for ouster_generate_header.

# Include the progress variables for this target.
include ouster-ros/ouster_example/CMakeFiles/ouster_generate_header.dir/progress.make

ouster_generate_header: ouster-ros/ouster_example/CMakeFiles/ouster_generate_header.dir/build.make
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Generating build info header"
	/usr/bin/cmake -DVERSION_GEN_OUT_DIR="/home/benni/catkin_ws/build/ouster-ros/ouster_example/generated/ouster/impl" -DVERSION_GEN_SOURCE_DIR="/home/benni/catkin_ws/src/ouster-ros/ouster-sdk/cmake" -DBUILD_TYPE="Release" -DBUILD_SYSTEM="Linux" -DOusterSDK_VERSION="0.7.1" -DOusterSDK_VERSION_SUFFIX="" -P /home/benni/catkin_ws/src/ouster-ros/ouster-sdk/cmake/VersionGen.cmake
.PHONY : ouster_generate_header

# Rule to build all files generated by this target.
ouster-ros/ouster_example/CMakeFiles/ouster_generate_header.dir/build: ouster_generate_header

.PHONY : ouster-ros/ouster_example/CMakeFiles/ouster_generate_header.dir/build

ouster-ros/ouster_example/CMakeFiles/ouster_generate_header.dir/clean:
	cd /home/benni/catkin_ws/build/ouster-ros/ouster_example && $(CMAKE_COMMAND) -P CMakeFiles/ouster_generate_header.dir/cmake_clean.cmake
.PHONY : ouster-ros/ouster_example/CMakeFiles/ouster_generate_header.dir/clean

ouster-ros/ouster_example/CMakeFiles/ouster_generate_header.dir/depend:
	cd /home/benni/catkin_ws/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/benni/catkin_ws/src /home/benni/catkin_ws/src/ouster-ros/ouster-sdk /home/benni/catkin_ws/build /home/benni/catkin_ws/build/ouster-ros/ouster_example /home/benni/catkin_ws/build/ouster-ros/ouster_example/CMakeFiles/ouster_generate_header.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : ouster-ros/ouster_example/CMakeFiles/ouster_generate_header.dir/depend

