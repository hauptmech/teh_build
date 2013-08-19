##############################################################################
#
# Welcome to our step-by-step cmake template. Follow the numbered instructions
#   below.
#
##############################################################################


##############################################################################
#
#   1. Set the project name. This will also be the name of your executable or
#       library.
#
##############################################################################
    SET(PRJ_NAME "teh_build_tools") 


    PROJECT(${PRJ_NAME})
    cmake_minimum_required(VERSION 2.8)

    set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/../CMakeModules")

    #add_definitions(-v) #Uncomment to have gcc dump detailed include/link info





##############################################################################
#
#   2. Find any dependencies.
#
##############################################################################

    # ./include holds the public api
#    include_directories(${CMAKE_SOURCE_DIR}/include)






##############################################################################
#
#   3. Specify the source files you will compile.
#       a. Add file to the ${SOURCES} variable
#       b. Uncomment "add_library" or "add_executable" 
#
##############################################################################

    file(GLOB GLOBBED_SOURCES src/*.{c,cpp})
    set( SOURCES
        #${GLOBBED_SOURCES}    #Uncomment to compile all *.cpp files instead listed ones.
        #Add source files here
        #src/myfile.cpp
    #    src/demo.c
    )

    #add_library(${PRJ_NAME} SHARED ${SOURCES} )
    #add_executable(${PRJ_NAME} ${SOURCES} )






##############################################################################
#
#   4. Specify any libraries that need to be linked in here.
#
##############################################################################

    set( LIBRARIES 
        #Explicit libraries to be linked, and FIND_PACKAGE libraries go here
    )
     
#    target_link_libraries(${PRJ_NAME} ${LIBRARIES} )



##############################################################################
#
#   5. Specify which header files need to be installed
#
##############################################################################

    file(GLOB GLOBBED_HEADERS include/*.{h,hpp})
    set( HEADERS_TO_INSTALL 
        #${GLOBBED_HEADERS}    #Uncomment to compile all *.cpp files instead listed ones.
        #Add include files to be installed here
    )

	set( BASH_SCRIPTS_TO_INSTALL
		bash/teh
	)


    #install(TARGETS ${PRJ_NAME} DESTINATION lib)
    #install(FILES ${HEADERS_TO_INSTALL} DESTINATION include)
	install(FILES ${BASH_SCRIPTS_TO_INSTALL} DESTINATION bin)





##############################################################################
#
#   6. Specify packaging variables
#
##############################################################################

set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_NAME ${PRJ_NAME})
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "1")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "")
set(CPACK_PACKAGE_DESCRIPTION "Build tools for newbs!")
set(CPACK_PACKAGE_CONTACT "traveler.hauptman@iit.it")

include(CPack)


############## SANITY CHECKS ##########################

    # Here we enforce a layout, or warn about the lack of it.
    IF (NOT EXISTS "${CMAKE_SOURCE_DIR}/../CMakeModules/")
        message(
" 

WARNING: We expected a CMakeModules directory to be in parallel.
         Do you need to check it out?

"           
        )
    ENDIF (NOT EXISTS "${CMAKE_SOURCE_DIR}/../CMakeModules/")












#########################################################
#                 QUICK REFERENCE                       #
#########################################################

# Typical variables from FIND_PACKAGE(lib)

#   LIB_FOUND - True False whether the library was found
#   LIB_INCLUDE_DIRS - Include directories of library
#   LIB_LIBRARIES - Link librarie
#   LIB_USE_FILE - File to be included for using library
 

