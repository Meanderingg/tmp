#!/bin/bash

cat /etc/hosts | while read address name 
do
    if [ "$address" == "#" ]; then
        break
    fi
    #echo "$address"
    flag0=0 
    flag1=0
    nslookup $name | while read line
    do
        #echo "$line"
        if [ "$flag1" == "1" ] ; then
            flag1=0
            if [ "$address" != "${line##* }" ] ; then
                echo "Bogus IP for $name in /etc/hosts!"
                echo "$name $address ${line##* }"
                break
            fi
        fi
        if [ "$flag0" == "1" ] ; then
            flag1=1
            flag0=0
        fi
        if [ "$line" == "Non-authoritative answer:" ] ; then
            flag0=1
        fi
    done
done
