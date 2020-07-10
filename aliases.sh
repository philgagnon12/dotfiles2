#Colored ls
ls --color=auto > /dev/null 2>&1
if [[ $? -eq 1 ]]; then alias ls='ls -G'; else alias ls='ls --color=auto'; fi
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"

alias pe="printenv | grep "

