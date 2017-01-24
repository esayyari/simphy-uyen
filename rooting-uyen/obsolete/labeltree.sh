#datapath=/home/uym2/simphy_root/simphy-uyen


for tree in `find $datapath -name $treename | sort`; do
	echo $tree
	LabelTree.py -i $tree -o `dirname $tree`/$treename\_labeled
done	
