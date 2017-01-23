#! /bin/bash

# check all the rooting possible (check all branches) and
# find the minimum triplet distance comparing to the true tree

truetree=$1
esttree=$2
opttree=$3 # output

info=`mktemp info-XXXXX`
tmptre=`mktemp tre-XXXXX`

min_dtrpl=`dtrpl_norm.sh $truetree $esttree`
cp $esttree $opttree

#nw_distance -n -mp -sa $esttree > $info
nw_labels $esttree > $info

while read line; do
	node=`echo $line | awk '{print $1}'`
	#x=`echo $line | awk '{print $2/2}'`
	#reroot_at_edge.py -i $esttree -n $node -d $x -o $tmptre
	nw_reroot $esttree $node > $tmptre
	dtrpl=`dtrpl_norm.sh $truetree $tmptre`
	cmp=`compare_numbers.py $min_dtrpl $dtrpl`
	if [ "$cmp" -eq 1 ]
	then
		min_dtrpl=$dtrpl
		cp $tmptre $opttree
	fi
done < $info

echo $min_dtrpl

rm $info $tmptre

