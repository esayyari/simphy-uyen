# !/bin/bash

infofile=$1
truetrees=$2

awk '{print $2;}' $infofile | paste - - - - | awk '{print $1,$2;}' > info_temp
nw_topology $truetrees > true_topology

while read info && read -u 3 truetree; do 
	echo $truetree > tree_temp
	br2trueroot.sh tree_temp $info
done < info_temp 3< true_topology

rm info_temp tree_temp true_topology
