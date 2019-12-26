#!/bin/bash
source ./config.cfg

stopServer () {
    str=$( grep $1 ps.txt )
    # echo $str
    ttys=$( grep -ho "ttys\d*" <<< "$str" )
    allTtys=$( grep $ttys ps.txt )
    pids=$( grep -ho "^ *\d*" <<< "$allTtys" )

    for pid in $pids
    do
         kill $pid 
    done
}

# declare -a arrayCSR
arrayCSR=($ARRAY_CSR)

if [ -z $1 ]
then
    ports=$(grep -ho "\d\d\d\d" <<< "$ARRAY_CSR")
    for port in $ports
    do
        stopServer $port
    done
else
    for server in $@
    do
        for ((i=0; i<${#arrayCSR[@]}; i++))
        do  
            if [[ ${arrayCSR[i]} =~ $server$ ]]
     then
       port=${arrayCSR[i+1]}
       stopServer $port
     fi
     done
done
fi
  
rm ps.txt
