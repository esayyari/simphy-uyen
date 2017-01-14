# ! /bin/bash

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
#grep "tree mpest" $fn.mpest.all | awk -F '= ' '{print $2;}' > $fn.mpest.tre

python -c '
import os
import sys
import dendropy
 
src_fpath = os.path.expanduser(os.path.expandvars("'$fn.mpest.all'"))
if not os.path.exists(src_fpath):
    sys.stderr.write("Not found: %s" % src_fpath) 
    sys.exit(1)     
 
dest_fpath = os.path.expanduser("'$fn.mpest.tre'")

trees = dendropy.TreeList.get_from_path(src_fpath, "nexus")
trees[-1].write_to_path(dest_fpath, "newick",suppress_rooting=True)'



test $? == 0 || exit 1
