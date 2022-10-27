# cmake .. -DCMAKE_INSTALL_PREFIX=dotfiles
# make
# make install
# sudo make oksh-shells
# make oksh-chsh

cmake_minimum_required( VERSION 3.16 )

project( dotfiles2 )

set( CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake" )

# PRE REQ programs
execute_process( COMMAND git --version )

set( PROFILE_PATH )

if(WIN32)
    include( vim )
else()
    include( oksh )
    include( base16-shell )
    include( vim )
    include( base16-vim )
    include( tmux )
endif()



################################################################################

# Setup PATH env var for oksh
list( JOIN PROFILE_PATHS ":" DOTFILES2_PATH )

# Copy .profile
configure_file( _profile ${CMAKE_CURRENT_BINARY_DIR}/_profile @ONLY )


install( FILES ${CMAKE_CURRENT_BINARY_DIR}/_profile
    DESTINATION     $ENV{HOME}
    RENAME          .profile
)

add_custom_target( todo ALL
    COMMAND echo "== TODO =="
    COMMAND echo "sudo make oksh-shells"
    COMMAND echo "make oksh-chsh"
    COMMAND echo "=========="
)
