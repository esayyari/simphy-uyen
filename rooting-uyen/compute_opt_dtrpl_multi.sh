#! /bin/bash

reftrees=$1
targtrees=$2
opttrees=$3 #output

if [ -e $opttrees ]; then
	rm $opttrees
fi

curr_ref=`mktemp ref-XXXXX`
curr_targ=`mktemp targ-XXXXX`
curr_opt=`mktemp opt-XXXXX`

while read ref && read -u 3 targ; do 
	echo $ref > $curr_ref
	echo $targ > $curr_targ
	compute_opt_dtrpl.sh $curr_ref $curr_targ $curr_opt
	cat $curr_opt >> $opttrees
done < $reftrees 3< $targtrees

rm $curr_ref $curr_targ $curr_opt

