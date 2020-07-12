configure_file( _tmux.conf ${CMAKE_CURRENT_BINARY_DIR}/_tmux.conf @ONLY )

file( COPY pain_control.tmux    DESTINATION ${CMAKE_INSTALL_PREFIX} )
file( COPY sensible.tmux        DESTINATION ${CMAKE_INSTALL_PREFIX} )
file( COPY tmux_buffer.sh       DESTINATION ${CMAKE_INSTALL_PREFIX} )
file( COPY tmux_vim.sh          DESTINATION ${CMAKE_INSTALL_PREFIX} )

install( FILES ${CMAKE_CURRENT_BINARY_DIR}/_tmux.conf
    DESTINATION     $ENV{HOME}
    RENAME          .tmux.conf
)

file( MAKE_DIRECTORY $ENV{HOME}/.tmux-buffers )

