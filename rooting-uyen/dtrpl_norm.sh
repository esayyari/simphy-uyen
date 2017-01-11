# !/bin/bash

tt=$1
et=$2

perl -pi -e 'chomp if eof' $tt
perl -pi -e 'chomp if eof' $et
nleaves=`nw_stats $tt | grep "leaves" | cut -f2`
ntrpl=`triplet_count.sh $nleaves`
ntrpl_error=`quart_bin calcTripDist $tt $et`

echo $ntrpl_error | numlist -div`echo $ntrpl`
