#! /bin/bash

#ms - the Matching Split metric,
#pd - the Path Difference metric,

ref_tree=$1
est_tree=$2

outfile=`mktemp`
infofile=`mktemp`

java -Xmx256m -jar /home/umai/Packages_N_Libraries/TreeCmp/bin/TreeCmp.jar -N -r $ref_tree -i $est_tree -d ms pd -o $outfile > $infofile 2 <&1
cat $outfile | tail -n 1 | awk '{print $4,$5,$6,$7,$8,$9;}'

rm $outfile $infofile

