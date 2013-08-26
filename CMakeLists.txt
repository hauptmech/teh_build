#Author: Traveler Hauptman, 23 Aug 2013
SET(PRJ_NAME "teh-build-tools") 

PROJECT(${PRJ_NAME})
cmake_minimum_required(VERSION 2.8)

set(CMAKE_INSTALL_PREFIX "/usr")
#Create our special config file
configure_file(${CMAKE_SOURCE_DIR}/cmake/teh-build-tools-config.cmake 
		  "${PRJ_NAME}-config.cmake" @ONLY)

set( BASH_SCRIPTS_TO_INSTALL
	bash/teh
)

install(PROGRAMS ${BASH_SCRIPTS_TO_INSTALL} DESTINATION bin)
install(FILES bash/teh_autocomplete DESTINATION /etc/bash_completion.d)
install(FILES ${CMAKE_BINARY_DIR}/${PRJ_NAME}-config.cmake DESTINATION share/${PRJ_NAME}/cmake)
install(FILES cmake/libConfig.cmake.in DESTINATION share/${PRJ_NAME}/cmake)

set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_NAME ${PRJ_NAME})
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "19")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Build tools for newbs!")
set(CPACK_PACKAGE_DESCRIPTION "The teh stript automates creating and publish repositories.")
set(CPACK_PACKAGE_CONTACT "traveler.hauptman@iit.it")

include(CPack)


