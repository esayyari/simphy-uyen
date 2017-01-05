# !/bin/bash

truetree=$1
head=$2
tail=$3

if [ "$tail" == "None" ]; then
	if [ "$head" == "None" ]; then
		echo 0
	else
		nw_distance $truetree $head
	fi
else
	dhead=`nw_distance $truetree $head`
	dtail=`nw_distance $truetree $tail`
	if [ $dhead -eq $dtail ]; then
		echo 0
	elif [ $dhead -lt $dtail ]; then
		echo $dhead
	else
		echo $dtail
	fi
fi
