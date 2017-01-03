#! /bin/bash

intree=$1
method=$2
outtree=$3
outinfo=$4

[ -e $outtree ] && rm $outtree
[ -e $outinfo ] && rm $outinfo
while read l; do echo $l > temp; FastRoot.py -i temp -m $method -o temp_tree -f temp_info; cat temp_tree >> $outtree; cat temp_info >> $outinfo;  done < $intree
rm temp temp_tree temp_info
