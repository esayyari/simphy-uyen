#! /bin/bash

reftrees=$1
targtrees=$2

curr_ref=`mktemp ref-XXXXX`
curr_targ=`mktemp targ-XXXXX`

while read ref && read -u 3 targ; do 
	echo $ref > $curr_ref
	echo $targ > $curr_targ
	compute_opt_dtrpl.sh $curr_ref $curr_targ
done < $reftrees 3< $targtrees

rm $curr_ref $curr_targ

