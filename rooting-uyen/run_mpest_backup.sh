# ! /bin/bash
# Note: only work with the convention of my experiments for the project
# species taxa and gene taxa are the same. Each species has only 1 taxon

fn=$1
tmp=`mktemp "control-$fn-XXXXX"`
echo "$fn
0
`expr $RANDOM$RANDOM % 10000000`
`cat $1|wc -l` `cat $2|wc -l`
`cat $2`
0
"> $tmp

mpest $tmp 1>$fn.mpest.out

mv $fn.tre $fn.mpest.all
grep "tree mpest" $fn.mpest.all | awk -F '= ' '{print $2;}' > $fn.mpest.tre

test $? == 0 || exit 1
