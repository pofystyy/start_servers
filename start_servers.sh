#!/bin/bash
arrayCSR=( CsR /telapp/tas 3030 /telapp/admin 3100 /telapp/member 3400 /telapp/provider 3500 /oms 5000 /erx-rails 3600 )
mainPath="$WORKING_DIRECTORY_PATH"

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

startServer () {
    startServerCommand=("$@")
    commands="cd $1 &&
              source ~/.bash_profile &&
              ${startServerCommand[@]:1}"

    openInNewWindow $commands
}

for p in $( seq 1 ${#arrayCSR[*]} )
do
    if [[ $((p % 2 )) -eq 0 ]]
        then
            path="$mainPath${arrayCSR[$(( p - 1 ))]}"
            command="bundle exec rails s -p ${arrayCSR[${p}]}"
            
            startServer $path $command
    fi
done

startServer "$mainPath/screenflow" "./start_local.sh -p 4000"
