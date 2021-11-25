find_package (Threads)
target_link_libraries(${LF_MAIN_TARGET} ${CMAKE_THREAD_LIBS_INIT} )

set(CROW_INCLUDE /home/revol-xut/workspace/Crow/include/)

target_include_directories(${LF_MAIN_TARGET} PUBLIC /home/revol-xut/workspace/Crow/include/)
#target_include_directories(${LF_MAIN_TARGET} "${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR}")
