#!/bin/bash


check(){

    name=$1
    addr=$2
    server=$3
    #ceva="$(nslookup $name 9.9.9.9)"
    #echo "$ceva"
    check="$(nslookup $name $server | grep -v '#' | grep -e 'Address' | grep -o '.*\..*\..*\..*')"
    a=( $check )
    #echo ${a[1]}
    #echo $addr
    if [ ${a[1]} = $addr ] ; then
        echo "Correct address"
    fi
}

check $1 $2 $3
