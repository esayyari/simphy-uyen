# ! /bin/bash

fn=$1
ctrl=`mktemp "control-$fn-XXXXX"`
map=`mktemp "map-$fn-XXXXX"`
species=`mktemp "species-$fn-XXXXX"`
cat $fn | sed -e "s/:[0-9.e-]*//g" -e "s/)[0-9.e-]*/)/g" -e "s/[(,);]/ /g" -e "s/ /\n/g"|sort|uniq|tail -n+2 > $species 
cat $species | sed -e "s/^\(.*\)$/\1 1 \1/g" > $map

echo "$fn
0
`expr $RANDOM$RANDOM % 10000000`
`cat $fn|wc -l` `cat $species|wc -l`
`cat $map`
0
"> $ctrl

mpest $ctrl >$fn.mpest.out

mv $fn.tre $fn.mpest.all
tmp_tre=`mktemp "tre-$fn-XXXXX"`
grep "tree mpest" $fn.mpest.all | awk -F '= ' '{print $2;}' > $tmp_tre
fix_mpest_output.py $tmp_tre $species $fn.mpest.tre

rm $ctrl $tmp_tre $map $species
