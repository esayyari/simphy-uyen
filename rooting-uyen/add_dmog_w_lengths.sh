#! /bin/bash

intrees=$1
og=$2
outfile=$3

# take the first tree as a "sample" tree and compute the average branch length
atree=`mktemp tree-XXXXX`
head -n 1 $intrees > $atree
L=`nw_distance -sa -mp $atree | numlist -avg`

cat $intrees | sed -e "s/^/($og:$L,/g" | sed -e "s/;/:$L);/" > $outfile

rm $atree
