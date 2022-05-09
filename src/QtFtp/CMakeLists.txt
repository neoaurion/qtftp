add_library(QFtp
    qftp.cpp
    qurlinfo.cpp
    )

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/..)


target_link_libraries( QFtp Qt5::Core Qt5::Network)

# state that anybody linking to us needs to include the current source dir
target_include_directories(QFtp
          INTERFACE
		  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
		  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/..>
		  $<INSTALL_INTERFACE:include>
          $<INSTALL_INTERFACE:include/QtFtp>
          )
		  
install(TARGETS QFtp DESTINATION lib EXPORT QFtp-targets)
