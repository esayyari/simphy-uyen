#! /bin/bash

intree=$1
method=$2
outtree=$3
outinfo=$4

[ -e $outtree ] && rm $outtree
[ -e $outinfo ] && rm $outinfo

while read l; do 
	echo $l > temp_in
	FastRoot.py -i temp_in -m $method -o temp_out -f temp_info
	cat temp_out >> $outtree
	cat temp_info >> $outinfo
	rm temp_in temp_out temp_info
done < $intree

