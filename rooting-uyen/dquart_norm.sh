# !/bin/bash

tt=$1
et=$2

perl -pi -e 'chomp if eof' $tt
perl -pi -e 'chomp if eof' $et
nleaves=`nw_stats $tt | grep "leaves" | cut -f2`
nqrt=`quartet_count.sh $nleaves`
nqrt_error=`quart_bin fancy calcQuartDist $tt $et`

echo $nqrt_error | numlist -div`echo $nqrt`
