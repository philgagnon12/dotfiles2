include( FetchContent )

if( NOT EXISTS "${CMAKE_SOURCE_DIR}/vendor/base16-vim" )
    message( "Download base16-vim" )

    FetchContent_Declare( base16-vim-dl
        GIT_REPOSITORY  "https://github.com/chriskempson/base16-vim"
        SOURCE_DIR      "${CMAKE_SOURCE_DIR}/vendor/base16-vim"
    )

    FetchContent_MakeAvailable( base16-vim-dl )
endif()


FetchContent_Declare( base16-vim
    URL "${CMAKE_SOURCE_DIR}/vendor/base16-vim"
)

FetchContent_MakeAvailable( base16-vim )

install( DIRECTORY ${base16-vim_SOURCE_DIR}/colors
    DESTINATION $ENV{HOME}/.vim
)
