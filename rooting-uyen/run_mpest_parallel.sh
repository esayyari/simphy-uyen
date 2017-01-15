# ! /bin/bash

fn=$1
np=$2

tmp=`mktemp "control-$fn-XXXXX"`
echo "$fn
0
`expr $RANDOM$RANDOM % 10000000`
`cat $1|wc -l` `cat $2|wc -l`
`cat $2`
0
"> $tmp

mpiexec -np $np mpest $tmp 1>$fn.mpest.out

mv $fn.tre $fn.mpest.all
tmp_tre=`mktemp "control-$fn-XXXXX"`
grep "tree mpest" $fn.mpest.all | awk -F '= ' '{print $2;}' > $tmp_tre
fix_mpest_output.sh $tmp_tre $fn.mpest.tre
