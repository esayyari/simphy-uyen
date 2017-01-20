#! /bin/bash

# check all the rooting possible (check all branches) and
# find the minimum triplet distance comparing to the true tree

truetree=$1
esttree=$2

info=`mktemp info-XXXXX`
tmptre=`mktemp tre-XXXXX`
nw_distance -n -mp -sa $esttree > $info

while read line; do
	node=`echo $line | awk '{print $1}'`
	x=`echo $line | awk '{print $2/2}'`
	reroot_at_edge.py -i $esttree -n $node -d $x -o $tmptre
	dtrpl_norm.sh $truetree $tmptre 
done < $info | numlist -min

rm $info $tmptre

