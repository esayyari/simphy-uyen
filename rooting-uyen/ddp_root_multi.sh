#! /bin/bash

intree=$1
outtree=$2
outtime=$3

[ -e $outtree ] && rm $outtree

while read l; do 
	echo $l > temp_in
	{ time dendropy_MP.py temp_in temp_out ; } 2>> $outtime
	cat temp_out >> $outtree
	rm temp_in temp_out 
done < $intree

