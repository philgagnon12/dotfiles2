cmake_minimum_required( VERSION 3.17.1 )

project( dotfiles2 )

set( CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake" )

set( PROFILE_PATH )

include( oksh )


# Copy .profile
file( COPY _profile DESTINATION ${CMAKE_CURRENT_BINARY_DIR} )
file( RENAME ${CMAKE_CURRENT_BINARY_DIR}/_profile ${CMAKE_CURRENT_BINARY_DIR}/.profile )

# Setup PATH env var for oksh
list( JOIN PROFILE_PATHS ":" PATH_VAR )

file( APPEND ${CMAKE_CURRENT_BINARY_DIR}/.profile "PATH=${PATH_VAR}:\$\{PATH\}" )
