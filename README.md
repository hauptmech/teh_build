teh_build is a clean, rapid project technique, that starts with a simple set 
of project files and puts no limits on the scale or granularity of the project
as it grows. 

This is made possible by eliminating some rare development use-cases and 
establishing some standard operating procedures.

Features:
--------

* No brainpower wasted trying to anticpate how the project will evolve
	+ Adapting (or forking) an existing project is not difficult.
	+ Splitting a project into separate libraries/executables is trivial.
	+ Scratching your head puzzling out complex cmake magic is not needed.

* Use the normal build chain in the normal way.
	(reinforce the knowledge you need for other projects)
	+ cmake project files are vanilla
	+ git, svn 
	+ kdevelop, qtcreator
	+ bash helper scripts save a little typing but are not necessary

* Seamlessly switch between developing dependent libraries in parallel with
	executables, and developing the executable with stable versions of the
	libraries.

* find_package() on a library using teh_build automatically finds all
	dependency libraries.

How it works:
------------

Dependency libraries for any project are normally installed installed at
the system level. To redirect your project to use a locally modified dependency
library simply build the version in your current development hierarchy.	

All libraries have a cmake *Config.cmake file which cmake uses to identify
the location of the lib and *.h files for that library. This file is 
generic for all projects (ie it does not have to be customized).

This *Config.cmake file tells cmake to search the local directory hierarchy
for actively developed libraries first, then the system installation locations.
	
	
How to install it:
-----------------

To use the CMake include and config files, no installation is needed. Just
grab the two files listed below in the usage section.

Installed, teh-build includes some bash helper scripts that can speed
up development.

Install teh_build from the source in the normal way:
		
    mkdir build; cd build; cmake ..
    make 
    sudo make install

How to use it:
--------------

teh_build/cmake/Sample* illustrate how to use the teh_* macros
teh_build/templates/* Also have examples

2 Options...

(1) Use the system installed files to load it

    find_package(teh-build)

(2) Embed it so teh-build does not need to be installed

    #add a 'cmake' directory to your source with a copy of 
    #'config.cmake.in' and 'teh-build.cmake'

    set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake)
    include(teh-build)


Modify and use your CMakeLists.txt exactly as you would for any other project.

	


