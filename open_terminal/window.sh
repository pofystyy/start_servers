#!/bin/bash

openInNewWindow () {
osascript &>/dev/null <<EOF
     tell application "iTerm2"
     set newWindow to (create window with default profile)
         tell current session of newWindow
             write text "$@"
         end tell
     end tell
EOF
}
