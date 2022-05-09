add_executable(ftpwindow
    main.cpp 
    ftpwindow.cpp 
    ftp.qrc)

target_link_libraries(ftpwindow PRIVATE QFtp Qt5::Core Qt5::Network Qt5::Widgets)

