# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.6

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
CMAKE_SOURCE_DIR = /home/ben/Programming/porthos-motor-control

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ben/Programming/porthos-motor-control/bld

# Utility rule file for get_calibration.

# Include the progress variables for this target.
include bin/CMakeFiles/get_calibration.dir/progress.make

bin/CMakeFiles/get_calibration:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/ben/Programming/porthos-motor-control/bld/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Write calibration status of internal oscillator to atmega16_calib.tmp."
	cd /home/ben/Programming/porthos-motor-control/bld/bin && avrdude -p atmega16 -c avrispmkII -P usb -U calibration:r:atmega16_calib.tmp:r

get_calibration: bin/CMakeFiles/get_calibration
get_calibration: bin/CMakeFiles/get_calibration.dir/build.make

.PHONY : get_calibration

# Rule to build all files generated by this target.
bin/CMakeFiles/get_calibration.dir/build: get_calibration

.PHONY : bin/CMakeFiles/get_calibration.dir/build

bin/CMakeFiles/get_calibration.dir/clean:
	cd /home/ben/Programming/porthos-motor-control/bld/bin && $(CMAKE_COMMAND) -P CMakeFiles/get_calibration.dir/cmake_clean.cmake
.PHONY : bin/CMakeFiles/get_calibration.dir/clean

bin/CMakeFiles/get_calibration.dir/depend:
	cd /home/ben/Programming/porthos-motor-control/bld && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ben/Programming/porthos-motor-control /home/ben/Programming/porthos-motor-control/bin /home/ben/Programming/porthos-motor-control/bld /home/ben/Programming/porthos-motor-control/bld/bin /home/ben/Programming/porthos-motor-control/bld/bin/CMakeFiles/get_calibration.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : bin/CMakeFiles/get_calibration.dir/depend

