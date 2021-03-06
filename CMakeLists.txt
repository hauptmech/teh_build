#Author: Traveler Hauptman, 23 Aug 2013
SET(PRJ_NAME "teh-build") 

PROJECT(${PRJ_NAME})
cmake_minimum_required(VERSION 2.8)

set(CMAKE_INSTALL_PREFIX "/usr")

set( BASH_SCRIPTS_TO_INSTALL
	bash/teh
	bash/teh_functions
	bash/teh_makeall
)

# Allow teh-build to be installed system wide
configure_file(${CMAKE_SOURCE_DIR}/cmake/teh-build.cmake 
          "${PRJ_NAME}-config.cmake" @ONLY)

install(FILES ${CMAKE_BINARY_DIR}/${PRJ_NAME}-config.cmake DESTINATION lib/${PRJ_NAME})
install(FILES cmake/libConfig.cmake.in DESTINATION lib/${PRJ_NAME})

install(PROGRAMS ${BASH_SCRIPTS_TO_INSTALL} DESTINATION bin)
install(FILES bash/teh_autocomplete DESTINATION /etc/bash_completion.d)
install(FILES cmake/${PRJ_NAME}.cmake DESTINATION share/${PRJ_NAME}/cmake)
install(FILES cmake/libConfig.cmake.in DESTINATION share/${PRJ_NAME}/cmake)
install(FILES cmake/SampleLibCMakeLists.txt DESTINATION share/${PRJ_NAME}/cmake)
install(FILES cmake/SampleBinCMakeLists.txt DESTINATION share/${PRJ_NAME}/cmake)

set(CPACK_GENERATOR "DEB")
set(CPACK_PACKAGE_NAME ${PRJ_NAME})
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "20")
set(CPACK_DEBIAN_PACKAGE_DEPENDS "")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "all")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Build tools for newbs!")
set(CPACK_PACKAGE_DESCRIPTION "The teh script automates creating and publish repositories.")
set(CPACK_PACKAGE_CONTACT "traveler.hauptman@iit.it")

include(CPack)

