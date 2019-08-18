#!/bin/bash

#!!!This script works only for class c network!!!


i1=$(hostname -I | awk 'BEGIN{FS=".";} {print $1}')
i2=$(hostname -I | awk 'BEGIN{FS=".";} {print $2}')
i3=$(hostname -I | awk 'BEGIN{FS=".";} {print $3}')
s=$(ip -o -f inet addr show| awk '/scope global/ {print $4}'|grep -oP "/\K.*")
echo "Live host in the network are"
if [ $s -eq 24 ];
then
 for ip in $i1.$i2.$i3.{1..254}
 do
  ping -c 1 $ip | grep -q "1 received" && echo $ip
   
 done
fi

if [ $s -eq 16 ];
then
 for i in {0..254}
 do
 for ip in $i1.$i2.$i.{1..254}
 do
  ping -c 1 $ip | grep -q "1 received" && echo $ip
   
 done
 done
fi


