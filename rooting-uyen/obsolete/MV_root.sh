#datapath=/home/uym2/simphy_root/simphy-uyen

for tree in `find $datapath -name $treename\_randroot | sort`; do
	echo $tree
	FastRoot.py -i $tree -m MV -o `dirname $tree`/$treename\_MV -f `dirname $tree`/$treename\_MV_info.txt
done

	
for tree in `find $datapath -name $treename\_ogrm_randroot | sort`; do
	echo $tree
	FastRoot.py -i $tree -m MV -o `dirname $tree`/$treename\_ogrm_MV -f `dirname $tree`/$treename\_ogrm_MV_info.txt
done	
