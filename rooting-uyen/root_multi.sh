#! /bin/bash

intree=$1
method=$2
outtree=$3
outinfo=$4
timefile=$5

[ -e $outtree ] && rm $outtree
[ -e $outinfo ] && rm $outinfo

temp_in=`mktemp tmp-XXXXX`
temp_out=`mktemp tmp-XXXXX`
temp_info=`mktemp tmp-XXXXX`


while read l; do 
	echo $l > $temp_in
	{ time FastRoot.py -i $temp_in -m $method -o $temp_out -f $temp_info; } 2 >> $timefile
	cat $temp_out >> $outtree
	cat $temp_info >> $outinfo
	rm $temp_in $temp_out $temp_info
done < $intree

