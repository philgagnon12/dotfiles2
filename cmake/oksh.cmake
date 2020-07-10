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
    COMMAND ${CMAKE_COMMAND}
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}
        -P ${CMAKE_CURRENT_LIST_FILE}.script
    WORKING_DIRECTORY ${oksh_SOURCE_DIR}
)

list( APPEND PROFILE_PATHS
    ${CMAKE_INSTALL_PREFIX}/oksh/bin
    ${CMAKE_INSTALL_PREFIX}/oksh/share/man/man1
)

