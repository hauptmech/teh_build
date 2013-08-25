# Authors: Traveler Hauptman, 23 August 2013
#
#	ATTENTION: if you know cmake, you can add modify or remove anything except
#              for the first two variables and the secret sauce without fear
#              of screwing something up. An explanation of how things work
#              is at the end of the file.
#
##############################################################################
#                            STEP 1
#
# Set the main library name. Also provide the name of a file in your public
# API include files that we can use to identify your project when looking
# for it later. This is a file located in <project>/include/* and typically  
# (as below) is will be in a subdirectory with the same name as your project 
# to avoid getting mixed up with include files from other projects after     
# installation.                                                              
#
# ...go to STEP 2 after changing the 2 lines below.
#
##############################################################################


    SET(LIBRARY_NAME "drc_demo")  #<-------Change!
    SET(INCLUDE_PATH_INDICATOR_FILE "drc_demo/drc_demo.h") #<------Change!

##############################################################################
# MAKE LIBRARY AWARE OF LOCAL DEVELOPMENT. DO NOT MODIFY UNLESS YOU KNOW HOW #
##############################################################################

# Create our ${LIBRARY_NAME}Config.cmake file
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/libConfig.cmake.in 
              "${LIBRARY_NAME}Config.cmake" @ONLY)
install(FILES "${LIBRARY_NAME}Config.cmake" DESTINATION lib/${LIBRARY_NAME})


# Specify where to search for local *Config.cmake and FindXXX.cmake files.
find_file(DEVROOT .development_root PATHS ${CMAKE_SOURCE_DIR}/.. PATH_SUFFIXES .. ../.. NO_DEFAULT_PATH)
if(${DEVROOT} MATCHES "DEVROOT-NOTFOUND")
    message("[WARNING] .development_root marker file not found.")
    set(DEVROOT ${CMAKE_SOURCE_DIR}/..)
else()
    get_filename_component(DEVROOT ${DEVROOT} PATH)
endif()

#find active projects
file(GLOB ACTIVE_LIBRARY_PATHS "${DEVROOT}/*/build" "${DEVROOT}/*/*/build" "${DEVROOT}/*/*/*/build")

# Search for config files buried in active projects
foreach(SRCH IN LISTS ACTIVE_LIBRARY_PATHS)
    file(GLOB_RECURSE CONFFILES ${SRCH}/*Config.cmake)
    foreach(conffile IN LISTS CONFFILES)
        get_filename_component(res ${conffile} PATH)
        list(APPEND LOCAL_FIND_LIBRARY_PATHS ${res})
        message("[]Adding config search path: ${res}")
    endforeach()
endforeach()

list(REMOVE_DUPLICATES LOCAL_FIND_LIBRARY_PATHS)

set(CMAKE_PREFIX_PATH ${LOCAL_FIND_LIBRARY_PATHS})
set(CMAKE_MODULE_PATH "${DEVROOT}/CMakeModules")

##############################################################################
# SECRET SAUCE ABOVE!!! DO NOT MODIFY UNLESS YOU KNOW WHAT YOU ARE DOING.    #
##############################################################################


	PROJECT(${LIBRARY_NAME})
	cmake_minimum_required(VERSION 2.8)

    #add_definitions(-v) #Uncomment to have gcc dump detailed include/link info



##############################################################################
#                              STEP 2
#
# Specify the source files you will compile.
#
##############################################################################

    #Add source files here
    set( LIBRARY1_SOURCES
        src/drc_demo.c      #<---- Change me!
        #src/myfile2.cpp    #<---- Add as many as you need to
        #src/myfile3.cpp
    )

    add_library(${LIBRARY_NAME} SHARED ${LIBRARY1_SOURCES} )


	## If you have more than one library, the second (and third, fourth, ...)
	## Will look like this.
    #set( LIBRARY2_SOURCES
        #src/myfile1.cpp    #<---- Add as many as you need to
        #src/myfile2.cpp    #<---- Add as many as you need to
        #src/myfile3.cpp
    #)

	## The line below makes liblibrary2.so
    #add_library(library2_name SHARED ${LIBRARY2_SOURCES} )


	## If you have a test or utility program for the library. it's added here.
    #set( EXE_SOURCES_1
        #src/myfile3.cpp
	#)
    #add_executable(program_name ${EXE_SOURCES_1} )




##############################################################################
#                               STEP 3
#
# List any additional include path to search during compilation. 
# Find any library dependencies your library needs
#
##############################################################################

	# Helper macro to add packages to dependency list
	#macro add_dependency(PKGNAME)
		#set(DEPENDENCIES "${DEPENDENCIES},${PKGNAME}")
	#endmacro()

    # ./include holds the public api
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)
	# ./src holds our code and private *.h files
    include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)


	## If you use fortran...
    #enable_language(Fortran)

	## Below is an example of using another library
    #find_package(Boost REQUIRED)
    #include_directories(${Boost_INCLUDE_DIRS})
    #link_directories(${Boost_LIBRARY_DIRS})
	#add_dependency("boost-all-dev")


# Typical variables from FIND_PACKAGE(libname)
#
#   libname_FOUND - True False whether the library was found
#   libname_INCLUDE_DIRS - Include directories of library
#   libname_LIBRARIES - Link librarie
#   libname_USE_FILE - File to be included for using library




##############################################################################
#                              STEP 4
#
# Specify any libraries that need to be linked in here.
#
##############################################################################

    set( LIBRARIES
        #Explicit libraries to be linked, and FIND_PACKAGE libraries go here
    )

    target_link_libraries(${LIBRARY_NAME} ${LIBRARIES} )

	#
    #target_link_libraries(program_nam lib1 ${LIBRARIES2})




##############################################################################
#                              STEP 5
#
# Specify which files need to be installed
#
##############################################################################


    install(TARGETS ${LIBRARY_NAME} DESTINATION lib/${LIBRARY_NAME})
    #install(TARGETS library2 DESTINATION lib/${LIBRARY_NAME})
    #install(TARGETS program1 DESTINATION bin)

	# Installs all the public API include files
	install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/include DESTINATION include)






##############################################################################
#                               STEP 6
#
# Specify packaging variables. If your library has dependencies on other 
# Ubuntu packages (including ones we create) then you should add below.
# Information on what these variables mean can be found at this webpage:
# http://www.cmake.org/Wiki/CMake:CPackPackageGenerators#DEB_.28UNIX_only.29
#
##############################################################################

set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "1")


set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "DRC demo application")
set(CPACK_PACKAGE_DESCRIPTION "
The drc demo library is a good place to start if you are developing your own."
)
set(CPACK_PACKAGE_CONTACT "traveler.hauptman@iit.it")


########### Leave the variables below as-is #############
set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_NAME ${LIBRARY_NAME})
set(CPACK_DEBIAN_PACKAGE_DEPENDS ${DEPENDENCIES})

include(CPack)


##############################################################################
#
#                           You are done! 
#
##############################################################################


# output for helper scripts and debugging
file(WRITE ${PROJECT_BINARY_DIR}/dependencies "${CPACK_DEBIAN_PACKAGE_DEPENDS}")
file(WRITE ${PROJECT_BINARY_DIR}/active_peers "${LOCAL_FIND_LIBRARY_PATHS}")


##############################################################################
# SECRET SAUCE BELOW!!! DO NOT MODIFY UNLESS YOU KNOW WHAT YOU ARE DOING.    #
##############################################################################
	configure_file(${CMAKE_CURRENT_SOURCE_DIR}/libConfig.cmake.in "${LIBRARY_NAME}Config.cmake" @ONLY)
	install(FILES "${LIBRARY_NAME}Config.cmake" DESTINATION lib/${LIBRARY_NAME})
##############################################################################
# SECRET SAUCE ABOVE!!! DO NOT MODIFY UNLESS YOU KNOW WHAT YOU ARE DOING.    #
##############################################################################



##############################################################################

#                    How it all works
#
#	Each of the libraries in our method have a libnameConfig.cmake file which
#   will use LOCAL_FIND_LIBRARY_PATHS to try to find itself locally before 
#   looking in the standard system locatins when find_package(libname) is 
#   used.
#
#   The variables LIBRARY_NAME and INCLUDE_PATH_INDICATOR_FILE are used when
#   generating the libnameConfig.cmake file (./cmake/config.cmake.in).




