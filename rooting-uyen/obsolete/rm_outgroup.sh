#datapath=/home/uym2/simphy_root/simphy-uyen

for tree in `find $datapath -name $treename\_labeled | sort`; do
	echo $tree
	treepath=`dirname $tree`
	nw_prune $tree 0 > $treepath/$treename\_ogrm
done	
