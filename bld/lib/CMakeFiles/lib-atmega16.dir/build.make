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

# Include any dependencies generated for this target.
include lib/CMakeFiles/lib-atmega16.dir/depend.make

# Include the progress variables for this target.
include lib/CMakeFiles/lib-atmega16.dir/progress.make

# Include the compile flags for this target's objects.
include lib/CMakeFiles/lib-atmega16.dir/flags.make

lib/CMakeFiles/lib-atmega16.dir/lib.c.obj: lib/CMakeFiles/lib-atmega16.dir/flags.make
lib/CMakeFiles/lib-atmega16.dir/lib.c.obj: ../lib/lib.c
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ben/Programming/porthos-motor-control/bld/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object lib/CMakeFiles/lib-atmega16.dir/lib.c.obj"
	cd /home/ben/Programming/porthos-motor-control/bld/lib && /usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -o CMakeFiles/lib-atmega16.dir/lib.c.obj   -c /home/ben/Programming/porthos-motor-control/lib/lib.c

lib/CMakeFiles/lib-atmega16.dir/lib.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/lib-atmega16.dir/lib.c.i"
	cd /home/ben/Programming/porthos-motor-control/bld/lib && /usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/ben/Programming/porthos-motor-control/lib/lib.c > CMakeFiles/lib-atmega16.dir/lib.c.i

lib/CMakeFiles/lib-atmega16.dir/lib.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/lib-atmega16.dir/lib.c.s"
	cd /home/ben/Programming/porthos-motor-control/bld/lib && /usr/bin/avr-gcc  $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/ben/Programming/porthos-motor-control/lib/lib.c -o CMakeFiles/lib-atmega16.dir/lib.c.s

lib/CMakeFiles/lib-atmega16.dir/lib.c.obj.requires:

.PHONY : lib/CMakeFiles/lib-atmega16.dir/lib.c.obj.requires

lib/CMakeFiles/lib-atmega16.dir/lib.c.obj.provides: lib/CMakeFiles/lib-atmega16.dir/lib.c.obj.requires
	$(MAKE) -f lib/CMakeFiles/lib-atmega16.dir/build.make lib/CMakeFiles/lib-atmega16.dir/lib.c.obj.provides.build
.PHONY : lib/CMakeFiles/lib-atmega16.dir/lib.c.obj.provides

lib/CMakeFiles/lib-atmega16.dir/lib.c.obj.provides.build: lib/CMakeFiles/lib-atmega16.dir/lib.c.obj


# Object files for target lib-atmega16
lib__atmega16_OBJECTS = \
"CMakeFiles/lib-atmega16.dir/lib.c.obj"

# External object files for target lib-atmega16
lib__atmega16_EXTERNAL_OBJECTS =

lib/liblib-atmega16.a: lib/CMakeFiles/lib-atmega16.dir/lib.c.obj
lib/liblib-atmega16.a: lib/CMakeFiles/lib-atmega16.dir/build.make
lib/liblib-atmega16.a: lib/CMakeFiles/lib-atmega16.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ben/Programming/porthos-motor-control/bld/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C static library liblib-atmega16.a"
	cd /home/ben/Programming/porthos-motor-control/bld/lib && $(CMAKE_COMMAND) -P CMakeFiles/lib-atmega16.dir/cmake_clean_target.cmake
	cd /home/ben/Programming/porthos-motor-control/bld/lib && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/lib-atmega16.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
lib/CMakeFiles/lib-atmega16.dir/build: lib/liblib-atmega16.a

.PHONY : lib/CMakeFiles/lib-atmega16.dir/build

lib/CMakeFiles/lib-atmega16.dir/requires: lib/CMakeFiles/lib-atmega16.dir/lib.c.obj.requires

.PHONY : lib/CMakeFiles/lib-atmega16.dir/requires

lib/CMakeFiles/lib-atmega16.dir/clean:
	cd /home/ben/Programming/porthos-motor-control/bld/lib && $(CMAKE_COMMAND) -P CMakeFiles/lib-atmega16.dir/cmake_clean.cmake
.PHONY : lib/CMakeFiles/lib-atmega16.dir/clean

lib/CMakeFiles/lib-atmega16.dir/depend:
	cd /home/ben/Programming/porthos-motor-control/bld && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ben/Programming/porthos-motor-control /home/ben/Programming/porthos-motor-control/lib /home/ben/Programming/porthos-motor-control/bld /home/ben/Programming/porthos-motor-control/bld/lib /home/ben/Programming/porthos-motor-control/bld/lib/CMakeFiles/lib-atmega16.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lib/CMakeFiles/lib-atmega16.dir/depend

