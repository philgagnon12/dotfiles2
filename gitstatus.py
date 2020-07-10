#!/usr/bin/python3

import curses
import subprocess
import re

curses.setupterm()
clear = curses.tigetstr("sgr0")

# blue = curses.tparm(curses.tigetstr("setaf"), 4 )
cyan = curses.tparm(curses.tigetstr("setaf"), 6 )
green = curses.tparm(curses.tigetstr("setaf"), 2 )
red = curses.tparm(curses.tigetstr("setaf"), 1 )

symbol_git_branch='⑂'
symbol_git_modified='*'
symbol_git_push='↑'
symbol_git_pull='↓'

# Need apt-get install python3.8
gitstatus = subprocess.run(["git", "status", "--porcelain=2", "-b"], capture_output=True)

if gitstatus.returncode == 0:

    stdout = gitstatus.stdout.decode("ascii")

    branch = re.compile("^# branch\.head (.+)", re.MULTILINE ).search(stdout).group(1)
    ab_m = re.compile("^# branch\.ab \+([0-9]+) \-([0-9]+)", re.MULTILINE ).search(stdout)

    output = cyan + symbol_git_branch.encode() + branch.encode() + " ".encode()
    if ab_m:
        ahead = ab_m.group(1)
        behind = ab_m.group(2)

        if int(ahead) > 0:
            output += green + symbol_git_push.encode() + ahead.encode()

        if int(behind) > 0:
            output += red + symbol_git_pull.encode() + behind.encode()

        output += clear

    curses.putp(output)



