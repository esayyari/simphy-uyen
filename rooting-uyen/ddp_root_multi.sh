#! /bin/bash

intree=$1
outtree=$2
outtime=$3

[ -e $outtree ] && rm $outtree
in=`mktemp in-XXXXX`
out=`mktemp out-XXXXX`
while read l; do 
	echo $l > $in
	{ time dendropy_MP.py $in $out ; } 2>> $outtime
	cat $out >> $outtree
	rm $in $out
done < $intree

