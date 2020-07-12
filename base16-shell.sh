#! /usr/bin/env bash

# Base16 Shell
[ -n "$PS1" ] && \
    [ -s "@CMAKE_SOURCE_DIR@/vendor/base16-shell/profile_helper.sh" ] && \
        eval "$("@CMAKE_SOURCE_DIR@/vendor/base16-shell/profile_helper.sh")"

