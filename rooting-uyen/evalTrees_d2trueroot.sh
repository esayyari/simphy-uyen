# !/bin/bash

infofile=$1
truetrees=$2
randroot=$3

awk '{print $2;}' $infofile | paste - - - - > info_temp

while read info && read -u 3 truetree; do 
	echo $truetree > tree_temp
	d2trueRoot.sh $info 30 tree_temp
done < info_temp 3< $truetrees | grep "d = " | awk -F 'd = ' '{print $2;}' | numlist -avg

rm info_temp tree_temp
