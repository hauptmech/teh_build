# TEH cmake scripts

# Author: Traveler Hauptman, Aug 2013

# Scripts for automatic finding and usage of dependency libraries that 
# may or may not be installed, and may or may not be in active development.
#
# teh_find_local_libraries() - Search for local cmake projects with build dirs
#		and add them to the cmake config file search path.
#
# teh_add_dependency(LIBNAME) - Add a library used by this package to the 
#		dependency chain so that upstream code that uses find_package()
#		will also include this depency library.
#
# teh_add_target(LIBNAME) -	Add a target library from this project to the
#		list of libraries exposed with find_package()
#
# teh_create_config_file(MY_LIBRARY_NAME INC_PATH_INDICATOR_FILE) - 
#		Create the cmake config file that will be used by upstream
#		code using find_package() for this library.
#


# Search local directories for dependency libraries that are active (built) and therefore
# should be included in this build.

macro (teh_find_local_libraries)
	# Specify where to search for local *Config.cmake and FindXXX.cmake files.
	find_file(DEVROOT .development_root PATHS ${CMAKE_SOURCE_DIR}/.. PATH_SUFFIXES .. ../.. NO_DEFAULT_PATH)
	if(${DEVROOT} MATCHES "DEVROOT-NOTFOUND")
		message("[WARNING] .development_root marker file not found.")
		set(DEVROOT ${CMAKE_SOURCE_DIR}/..)
	else()
		get_filename_component(DEVROOT ${DEVROOT} PATH)
	endif()

	#find active projects (indicated by the existance of a build directory)
	file(GLOB ACTIVE_LIBRARY_PATHS "${DEVROOT}/*/build" "${DEVROOT}/*/*/build" "${DEVROOT}/*/*/*/build")

	# Search for config files buried in active projects
	unset(REALLY_LOCAL_FIND_LIBRARY_PATHS)
	foreach(SRCH IN LISTS ACTIVE_LIBRARY_PATHS)
		file(GLOB_RECURSE CONFFILES ${SRCH}/*Config.cmake)
		foreach(conffile IN LISTS CONFFILES)
			get_filename_component(res ${conffile} PATH)
			list(APPEND REALLY_LOCAL_FIND_LIBRARY_PATHS ${res})
		endforeach()
	endforeach()

	# Clean up list to reduce processing time
	list(REMOVE_DUPLICATES REALLY_LOCAL_FIND_LIBRARY_PATHS) 

	# Verbose output
	message("== Search paths for: ${CMAKE_CURRENT_SOURCE_DIR} ==")
	foreach(PTH IN LISTS REALLY_LOCAL_FIND_LIBRARY_PATHS)
		message("[] ${PTH}")
	endforeach()
	message("===================================================")

	list(APPEND LOCAL_FIND_LIBRARY_PATHS  ${REALLY_LOCAL_FIND_LIBRARY_PATHS})

	set(CMAKE_PREFIX_PATH ${LOCAL_FIND_LIBRARY_PATHS})
endmacro()

# Add this target to the list of targets searched during configuration
macro (teh_add_target LIBNAME)
	if (TARGET ${LIBNAME})
		message("Adding library: ${LIBNAME}")
		LIST(APPEND TEH_EXPORTED_LIBRARIES ${LIBNAME})
	else()
		message(FATAL_ERROR "${LIBNAME} is not an active target. Perhaps you need to create it with 'add_libary' or 'add_executable'?")
	endif()
endmacro()


# Add this dependency to the dependency chain searched during configuration
macro (teh_add_dependency LIBNAME)
	LIST(APPEND TEH_DEPENDENCY_LIBRARIES "${LIBNAME}")
endmacro()

set(TEH_BUILD_DIR ${CMAKE_CURRENT_LIST_DIR})

# Create our ${LIBRARY_NAME}Config.cmake file
macro (teh_create_config_file MY_LIBRARY_NAME INC_PATH_INDICATOR_FILE )
	set(TEH_INCLUDE_PATH_INDICATOR_FILE ${INC_PATH_INDICATOR_FILE})
	set(TEH_LIBRARY_NAME ${MY_LIBRARY_NAME})
	set(TEH_INC_SUFFIX ${ARGV2})

	# Verify library name exists
	if(NOT TEH_LIBRARY_NAME)
		message(FATAL_ERROR " the variable $LIBRARY_NAME must be set to the name of this library! ")
	endif()

	# Verify include file exists
	if(NOT TEH_INCLUDE_PATH_INDICATOR_FILE)
		message(FATAL_ERROR " the variable $INCLUDE_PATH_INDICATOR_FILE must be set to an include file that can be used in searches to identify the location of this package when installed! ")
	endif()

#	message("Searching: \n    ${CMAKE_MODULE_PATH}\n    ${CMAKE_CURRENT_LIST_DIR}\n    ${TEH_BUILD_DIR}")
	find_file(CONF_FILE_PATH libConfig.cmake.in PATHS ${CMAKE_MODULE_PATH} ${TEH_BUILD_DIR} )
#    message("Found: ${CONF_FILE_PATH}")
	configure_file(${CONF_FILE_PATH} "${TEH_LIBRARY_NAME}Config.cmake" @ONLY)
	install(FILES "${PROJECT_BINARY_DIR}/${TEH_LIBRARY_NAME}Config.cmake" DESTINATION lib/${TEH_LIBRARY_NAME})

endmacro()


# Macros for loading VAR=VALUE files
# Load only variables that are in the provided parms list
# Case sensitive
# loadfile(MYINI_ "myfile.ini" "Name;Sex")
macro(teh_ini PREFIX INFILE PARMS)
file(STRINGS "${INFILE}" NEWBS REGEX ".*=.*")
foreach(VAR IN LISTS PARMS)
  foreach(LINE IN LISTS NEWBS)
    if(LINE MATCHES "${VAR}.*=(.*)")
      string(STRIP "${CMAKE_MATCH_1}" ${PREFIX}${VAR})
    endif()
  endforeach()
  if(NOT ${PREFIX}${VAR})
      message("MISSING ${VAR}")
  endif()
endforeach()
endmacro()

#Automatically assign a variable for each var in the file.
macro(teh_ini_all PREFIX INFILE )
file(STRINGS "${INFILE}" NEWBS REGEX ".*=.*")
  foreach(LINE IN LISTS NEWBS)
    if(LINE MATCHES "(.*)=(.*)")
      string(STRIP "${CMAKE_MATCH_1}" VAR)
      string(STRIP "${CMAKE_MATCH_2}" ${PREFIX}${VAR})
    endif()
  endforeach()
endmacro()




