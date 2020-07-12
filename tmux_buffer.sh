#!/usr/bin/env sh

# ISSUES : loss of unamed buffer (0)

BUFFER_FILES_PATH=${HOME}/.tmux-buffers

init() {
    keyBind
    loadBuffers
}

keyBind() {
    tmux unbind-key -T copy-mode-vi y
    tmux bind-key   -T copy-mode-vi y "run-shell" "$0 copySelectionPromptForBufferName"

    tmux unbind-key -T prefix "]"
    tmux bind-key   -T prefix "]" "run-shell" "$0 promptPasteBufferName"
}

loadBuffers () {
    if [ -d "${BUFFER_FILES_PATH}" ]
        then find ${BUFFER_FILES_PATH} -type f -exec $0 loadBuffer {} ";"
    fi
}

BUFFER_FILE_PATH=$2
loadBuffer() {
    echo $BUFFER_FILE_PATH
    BUFFER_NAME=$(basename $BUFFER_FILE_PATH);
    tmux load-buffer -b $BUFFER_NAME $BUFFER_FILE_PATH
}



copySelectionPromptForBufferName() {
    tmux send-keys -X copy-selection-and-cancel
    tmux command-prompt -p "buffer-name" "run-shell \"$0 setBuffer %%\""
}

BUFFER_NAME=$2
setBuffer() {
    if [ -n "$BUFFER_NAME" ]
        then tmux set-buffer -b 0 -n $BUFFER_NAME
    fi
}

promptPasteBufferName() {
    tmux command-prompt -p "buffer-name"  "run-shell \"$0 pasteBuffer %%\""
}

pasteBuffer(){
    if [ -n "${BUFFER_NAME}" ]
        then tmux paste-buffer -b ${BUFFER_NAME}
        else tmux paste-buffer
    fi
}

$1
