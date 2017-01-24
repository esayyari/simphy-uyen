# !/bin/bash

intrees=$1
outtrees=$2
temp=`mktemp`

# resolve polytomies
arb_resolve_polytomies.py $intrees

# add "S" to the begining of each taxon and remove all internal labels
cat $intrees.resolved |sed -e "s/\([(,]\)\([0-9][^:]*\):/\1S\2:/g" | nw_topology -I -b - > $outtrees

rm $intrees.resolved
