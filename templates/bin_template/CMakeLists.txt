# Authors: Traveler Hauptman, 23 August 2013
#
##############################################################################
#                            STEP 1
#
# Set the main executable name. 
#
# ...go to STEP 2 after changing the line below.
#
##############################################################################

    SET(EXECUTABLE_NAME "drc_demo")  #<-------Change!


    PROJECT(${EXECUTABLE_NAME})
    cmake_minimum_required(VERSION 2.8)

    # Locate all 
    find_package(teh-build)
    teh_find_local_libraries()






##############################################################################
#                               STEP 2
#
# List any additional include path to search during compilation. 
# Find any library dependencies your library needs
#
##############################################################################

	# ./src holds our code and private *.h files
    include_directories(${CMAKE_SOURCE_DIR}/src)


	## If you use fortran...
    #enable_language(Fortran)

	## Below is an example of using another library
    find_package(drc_demo REQUIRED)
    INCLUDE_DIRECTORIES(${drc_demo_INCLUDE_DIRS})





##############################################################################
#                              STEP 3
#
# Specify the source files you will compile.
#
##############################################################################

    #Add source files here
    set( LIBRARY1_SOURCES
        src/drc_demo_bin.c      #<---- Change me!
        #src/myfile2.cpp    #<---- Add as many as you need to
        #src/myfile3.cpp
    )

    add_executable(${EXECUTABLE_NAME} ${LIBRARY1_SOURCES} )


	## If you have another program it's added here.
    #set( EXE_SOURCES_1
        #src/myfile3.cpp
	#)
    #add_executable(program_name ${EXE_SOURCES_1} )






##############################################################################
#                              STEP 4
#
# Specify any libraries that need to be linked in here.
#
##############################################################################

    set( LIBRARIES
        #Explicit libraries to be linked, and FIND_PACKAGE libraries go here
		${drc_demo_LIBRARIES} #<---- this is our demo library found by find_package()
		#pthreads <--- you can directly add library names
    )

    target_link_libraries(${EXECUTABLE_NAME} ${LIBRARIES} )

	#
    #target_link_libraries(program_nam lib1 ${LIBRARIES2})




##############################################################################
#                              STEP 5
#
# Specify which files need to be installed
#
##############################################################################


    install(TARGETS ${EXECUTABLE_NAME} DESTINATION bin)
    #install(TARGETS program1 DESTINATION bin)

	

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

set(CPACK_DEBIAN_PACKAGE_DEPENDS "")

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "DRC demo application")
set(CPACK_PACKAGE_DESCRIPTION "
The drc demo program is a good place to start if you are developing your own."
)
set(CPACK_PACKAGE_CONTACT "traveler.hauptman@iit.it")


########### Leave the variables below as-is #############
set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_NAME ${EXECUTABLE_NAME})

include(CPack)


##############################################################################
#
#                           You are done! 
#
##############################################################################

file(WRITE ${PROJECT_BINARY_DIR}/dependencies "${CPACK_DEBIAN_PACKAGE_DEPENDS}")
file(WRITE ${PROJECT_BINARY_DIR}/active_peers "${LOCAL_FIND_LIBRARY_PATHS}")



#########################################################
#                 QUICK REFERENCE                       #
#########################################################

# Typical variables from FIND_PACKAGE(libname)

#   libname_FOUND - True False whether the library was found
#   libname_INCLUDE_DIRS - Include directories of library
#   libname_LIBRARIES - Link librarie
#   libname_USE_FILE - File to be included for using library

