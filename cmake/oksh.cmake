include( FetchContent )

if( NOT EXISTS "${CMAKE_SOURCE_DIR}/vendor/oksh" )
    message( "Download oksh" )

    FetchContent_Declare( oksh-dl
        GIT_REPOSITORY  "https://github.com/ibara/oksh"
        SOURCE_DIR      "${CMAKE_SOURCE_DIR}/vendor/oksh"
    )

    FetchContent_MakeAvailable( oksh-dl )
endif()


FetchContent_Declare( oksh
    URL "${CMAKE_SOURCE_DIR}/vendor/oksh"
)

FetchContent_MakeAvailable( oksh )

add_custom_target( oksh ALL
    COMMAND ./configure --prefix=${CMAKE_INSTALL_PREFIX}/oksh
    COMMAND ${CMAKE_MAKE_PROGRAM}
    COMMAND ${CMAKE_MAKE_PROGRAM} install
    WORKING_DIRECTORY ${oksh_SOURCE_DIR}
)

# target to be run with sudo, to add oksh to standard shells
add_custom_target( oksh-shells
    COMMAND ${CMAKE_COMMAND}
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -P ${CMAKE_CURRENT_LIST_FILE}.script
)

# target to be run as user, to change shell
add_custom_target( oksh-chsh
    COMMAND chsh -s ${CMAKE_INSTALL_PREFIX}/oksh/bin/oksh
)

list( APPEND PROFILE_PATHS
    ${CMAKE_INSTALL_PREFIX}/oksh/bin
    ${CMAKE_INSTALL_PREFIX}/oksh/share/man/man1
)

file( COPY aliases.sh DESTINATION ${CMAKE_INSTALL_PREFIX} )
file( COPY base16-shell.sh DESTINATION ${CMAKE_INSTALL_PREFIX} )
file( COPY gitstatus.py DESTINATION ${CMAKE_INSTALL_PREFIX} )
