cmake_minimum_required(VERSION 3.1)

# set the project name and version
project(QFtp VERSION 1.0)

if(MSVC)
# specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /wd4005")
else(MSVC)
# specify the C++ standard
set(CMAKE_CXX_STANDARD 14)
endif(MSVC)

set(CMAKE_CXX_STANDARD_REQUIRED True)


find_package(Qt5 COMPONENTS Core Network Widgets  REQUIRED)

# qt
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

if(CMAKE_VERSION VERSION_LESS "3.7.0")
    set(CMAKE_INCLUDE_CURRENT_DIR ON)
endif()

add_subdirectory(src)
#add_subdirectory(examples)

# INSTALL RULES
install(EXPORT QFtp-targets DESTINATION lib)
install(EXPORT QFtp-targets
  FILE QFtpTargets.cmake
  #NAMESPACE QFtp::
  DESTINATION share/QFtp/cmake
)


install(FILES "${CMAKE_SOURCE_DIR}/cmakeFindModules/QFtpConfig.cmake"
        DESTINATION share/QFtp/cmake)
