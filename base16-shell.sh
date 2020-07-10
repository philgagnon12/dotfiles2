#! /usr/bin/env bash

DESTINATION=$1

if [[ -z $DESTINATION ]]; then
    echo "Could not initialize base16-shell DESTINATION required"
    exit
fi

# Base16 Shell
[ -n "$PS1" ] && \
    [ -s "${DESTINATION}/profile_helper.sh" ] && \
        eval "$("$DESTINATION/profile_helper.sh")"

