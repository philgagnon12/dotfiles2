configure_file( _vimrc ${CMAKE_CURRENT_BINARY_DIR}/_vimrc @ONLY )
file( COPY sensible.vim DESTINATION ${CMAKE_INSTALL_PREFIX} )
file( COPY base16-shell.vim DESTINATION ${CMAKE_INSTALL_PREFIX} )

install( FILES ${CMAKE_CURRENT_BINARY_DIR}/_vimrc
	DESTINATION	$<IF:$<BOOL:${WIN32}>,$ENV{LOCALAPPDATA}/nvim,$ENV{HOME}>
	RENAME		$<IF:$<BOOL:${WIN32}>,init.vim,.vimrc> # init.vim(neovim)
)

