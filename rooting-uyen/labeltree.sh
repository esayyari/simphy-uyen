datapath=/home/uym2/simphy_root/simphy-uyen

for tree in `find $datapath -name truegenetrees | sort`; do
	echo $tree
	LabelTree.py -i $tree -o `dirname $tree`/truegenetrees_labeled
done	
