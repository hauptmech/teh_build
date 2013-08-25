
macro (teh_create_cmake_config LIBRARY_NAME INCLUDE_PATH_INDICATOR_FILE)
# Create our ${LIBRARY_NAME}Config.cmake file
configure_file(@CMAKE_INSTALL_PREFIX@/share/teh-build-tools/cmake/libConfig.cmake.in 
              "${LIBRARY_NAME}-config.cmake" @ONLY)
install(FILES "${LIBRARY_NAME}-config.cmake" DESTINATION lib/${LIBRARY_NAME})
endmacro()




macro (teh_find_libraries_in_development)
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
unset(REALLY_LOCAL_FIND_LIBRARY_PATHS)
foreach(SRCH IN LISTS ACTIVE_LIBRARY_PATHS)
    file(GLOB_RECURSE CONFFILES ${SRCH}/*Config.cmake)
    foreach(conffile IN LISTS CONFFILES)
        get_filename_component(res ${conffile} PATH)
        list(APPEND REALLY_LOCAL_FIND_LIBRARY_PATHS ${res})
    endforeach()
endforeach()

list(REMOVE_DUPLICATES REALLY_LOCAL_FIND_LIBRARY_PATHS) 

message("== Search paths for: ${CMAKE_CURRENT_SOURCE_DIR} ==")
foreach(PTH IN LISTS REALLY_LOCAL_FIND_LIBRARY_PATHS)
message("[] ${PTH}")
endforeach()

list(APPEND LOCAL_FIND_LIBRARY_PATHS  ${REALLY_LOCAL_FIND_LIBRARY_PATHS})

set(CMAKE_PREFIX_PATH ${LOCAL_FIND_LIBRARY_PATHS})
set(CMAKE_MODULE_PATH "${DEVROOT}/CMakeModules")
endmacro()



