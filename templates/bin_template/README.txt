This is a elegant executable template for cmake.

To keep things simple we have to follow a small set of conventions... 

1. All other libraries that you are actively developing and are used by this 
   program must share a common parent directory no more than 3 directories up.

2. If you want to use the system installed version of one of your libraries,
   you deactivate your development library by deleting or moving its ./build
   directory.

3. CMAKE_MODULE_PATH point to where teh-build.cmake is located, or alternately,
   teh-build is installed at the system level (ie in /usr/*)

4. The libConfig.cmake.in template file is in the same directory as teh-build.cmake

5. Your projects CMakeLists.txt uses the teh-* macros to create config files for
   libraries and search peer directories for dependencies. See the CMakeLists.txt
   for details.




That's it. Simple. What you get in return is that each project only needs
one CMakeLists.txt, which is clean and simple, with no limits on how complicated
you can make it if you need to. Each project will automatically find it's peers.




When you first start a new project from this template
=====================================================

  Edit the CMakeLists.txt file:
  -----------------------------

	Follow the instructions in the file. If you are experienced with 
	cmake, you can add or change anything you like.
	

  Start coding!
  -------------

    Remember to add new source files to section 3 as you create them.



A note on dependencies
======================

The one thing we give up in this simplicity is that cmake no longer solves the
dependencies between networks of libraries being developed simultaneously.

That's ok, because embedding this info in the cmake file is brittle and error
prone. There are two alternatives that are acceptable.

1. Typically we work on an application and do minor bug fixes or feature addition
on a couple libraries, with no more than 1 or 2 layers of dependencies. This will
be between 2 and 8 projects... You can easily manually set the build order in 
your IDE (you'll have to do this once).

2. The dependencies are capture in the cmake debian package variables. A short 
shell script (bash, python, etc) can walk the project directories, extract the
dependencies, solve the tree, and build the projects.

In exchange for this concession we get an unbeatable elegance and flexibility.





    
