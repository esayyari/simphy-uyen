# !/bin/bash
# usage: reroot_trees.sh <trees> <info> <outfile>
# infofile: each line has 2 components: label of the child(head) node and the distance of the root to the child(head) node

trees=$1
infofile=$2
outfile=$3


i=1

#awk '{print $2;}' $infofile | paste - - - - > info_temp

[ -e $outfile ] && rm $outfile

while read info && read -u 3 tree; do 
	echo $i
	i=$((i+1))
	echo $tree > tree_temp
	reroot_at_edge.py tree_temp $info tree_out
	cat tree_out >> $outfile
done < $infofile 3< $trees

rm tree_out tree_temp
