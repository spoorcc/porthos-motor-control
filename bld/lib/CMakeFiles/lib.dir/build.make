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

# Utility rule file for lib.

# Include the progress variables for this target.
include lib/CMakeFiles/lib.dir/progress.make

lib/CMakeFiles/lib: lib/liblib-atmega16.a


lib: lib/CMakeFiles/lib
lib: lib/CMakeFiles/lib.dir/build.make

.PHONY : lib

# Rule to build all files generated by this target.
lib/CMakeFiles/lib.dir/build: lib

.PHONY : lib/CMakeFiles/lib.dir/build

lib/CMakeFiles/lib.dir/clean:
	cd /home/ben/Programming/porthos-motor-control/bld/lib && $(CMAKE_COMMAND) -P CMakeFiles/lib.dir/cmake_clean.cmake
.PHONY : lib/CMakeFiles/lib.dir/clean

lib/CMakeFiles/lib.dir/depend:
	cd /home/ben/Programming/porthos-motor-control/bld && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ben/Programming/porthos-motor-control /home/ben/Programming/porthos-motor-control/lib /home/ben/Programming/porthos-motor-control/bld /home/ben/Programming/porthos-motor-control/bld/lib /home/ben/Programming/porthos-motor-control/bld/lib/CMakeFiles/lib.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lib/CMakeFiles/lib.dir/depend
