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
    SET(PRJ_NAME "teh-build-tools") 


    PROJECT(${PRJ_NAME})
    cmake_minimum_required(VERSION 2.8)




##############################################################################
#
#   5. Specify which header files need to be installed
#
##############################################################################
	set( BASH_SCRIPTS_TO_INSTALL
		bash/teh
	)


    #install(TARGETS ${PRJ_NAME} DESTINATION lib)
    #install(FILES ${HEADERS_TO_INSTALL} DESTINATION include)
	install(PROGRAMS ${BASH_SCRIPTS_TO_INSTALL} DESTINATION bin)





##############################################################################
#
#   6. Specify packaging variables
#
##############################################################################

set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_NAME ${PRJ_NAME})
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "3")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Build tools for newbs!")
set(CPACK_PACKAGE_DESCRIPTION "The teh stript automates creating and publish repositories.")
set(CPACK_PACKAGE_CONTACT "traveler.hauptman@iit.it")

include(CPack)


