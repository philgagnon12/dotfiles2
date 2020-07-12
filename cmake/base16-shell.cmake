include( FetchContent )

if( NOT EXISTS "${CMAKE_SOURCE_DIR}/vendor/base16-shell" )
    message( "Download base16-shell" )

    FetchContent_Declare( base16-shell-dl
        GIT_REPOSITORY  "https://github.com/chriskempson/base16-shell"
        SOURCE_DIR      "${CMAKE_SOURCE_DIR}/vendor/base16-shell"
    )

    FetchContent_MakeAvailable( base16-shell-dl )
endif()


FetchContent_Declare( base16-shell
    URL "${CMAKE_SOURCE_DIR}/vendor/base16-shell"
)

FetchContent_MakeAvailable( base16-shell )

configure_file( base16-shell.sh ${CMAKE_INSTALL_PREFIX}/base16-shell.sh @ONLY )
