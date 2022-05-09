# Called if we failed to find QFTP or any of it's required dependencies,
# unsets all public (designed to be used externally) variables and reports
# error message at priority depending upon [REQUIRED/QUIET/<NONE>] argument.
macro(QFTP_REPORT_NOT_FOUND REASON_MSG)
  # FindPackage() only references QFTP_FOUND, and requires it to be
  # explicitly set FALSE to denote not found (not merely undefined).
  set(QFTP_FOUND FALSE)

  # Reset the CMake module path to its state when this script was called.
  set(CMAKE_MODULE_PATH ${CALLERS_CMAKE_MODULE_PATH})

  # Note <package>_FIND_[REQUIRED/QUIETLY] variables defined by
  # FindPackage() use the camelcase library name, not uppercase.
  if (QFTP_FIND_QUIETLY)
    message(STATUS "Failed to find QFTP - " ${REASON_MSG} ${ARGN})
  elseif (QFTP_FIND_REQUIRED)
    message(FATAL_ERROR "Failed to find QFTP - " ${REASON_MSG} ${ARGN})
  else()
    # Neither QUIETLY nor REQUIRED, use SEND_ERROR which emits an error
    # that prevents generation, but continues configuration.
    message(SEND_ERROR "Failed to find QFTP - " ${REASON_MSG} ${ARGN})
  endif ()
  return()
endmacro(QFTP_REPORT_NOT_FOUND)

# Get the (current, i.e. installed) directory containing this file.
get_filename_component(CURRENT_CONFIG_INSTALL_DIR
  "${CMAKE_CURRENT_LIST_FILE}" PATH)

# Record the state of the CMake module path when this script was
# called so that we can ensure that we leave it in the same state on
# exit as it was on entry, but modify it locally.
set(CALLERS_CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH})
# Reset CMake module path to the installation directory of this
# script.
set(CMAKE_MODULE_PATH ${CURRENT_CONFIG_INSTALL_DIR})

# Build the absolute root install directory as a relative path
get_filename_component(CURRENT_ROOT_INSTALL_DIR
  ${CMAKE_MODULE_PATH}/../../../ ABSOLUTE)
if (NOT EXISTS ${CURRENT_ROOT_INSTALL_DIR})
  QFTP_REPORT_NOT_FOUND(
    "QFTP install root: ${CURRENT_ROOT_INSTALL_DIR}, "
    "determined from relative path from QFtpConfig.cmake install location: "
    "${CMAKE_MODULE_PATH}, does not exist.")
endif (NOT EXISTS ${CURRENT_ROOT_INSTALL_DIR})

# Check if QFTP header is installed
if (NOT EXISTS ${CURRENT_ROOT_INSTALL_DIR}/include/QtFtp/qftp.h)
  QFTP_REPORT_NOT_FOUND(
    "QFTP install root: ${CMAKE_MODULE_PATH}. "
    "Cannot find QFTP include files.")
endif (NOT EXISTS ${CURRENT_ROOT_INSTALL_DIR}/include/QtFtp/qftp.h)


# Import exported QFTP targets
include(${CURRENT_CONFIG_INSTALL_DIR}/QFtpTargets.cmake)

# As we use QFTP_REPORT_NOT_FOUND() to abort, if we reach this point we have
# found QFTP and all required dependencies.
message(STATUS "----")
message(STATUS "QFTP Find_Package")
message(STATUS "----")
message(STATUS "Found QFTP ")
message(STATUS "Installed in: ${CURRENT_ROOT_INSTALL_DIR}")
message(STATUS "----")

set(QFTP_FOUND TRUE)

# Reset the CMake module path to its state when this script was called.
set(CMAKE_MODULE_PATH ${CALLERS_CMAKE_MODULE_PATH})
