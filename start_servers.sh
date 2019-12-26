#!/bin/bash
source ./config.cfg
source ./open_terminal/tab.sh
source ./open_terminal/window.sh

flag=$1
arrayCSR=( CsR $ARRAY_CSR)
mainPath="$WORKING_DIRECTORY_PATH"

startServer () {
    startServerCommand=("$@")
    commands="cd $1 &&
              source ~/.bash_profile &&
              ${startServerCommand[@]:1}"
    if [ "$flag" == "-w" ]
    then
        openInNewWindow $commands
    else
        openInNewTab $commands
    fi
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

ps -A | grep "ttys\d*" > ps.txt
