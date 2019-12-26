#!/bin/bash

openInNewTab () {
osascript &>/dev/null <<EOF
    tell application "iTerm2"
        tell current window
         create tab with default profile
             tell the current session
                 write text "$@"
             end tell
         end tell
     end tell
EOF
}
