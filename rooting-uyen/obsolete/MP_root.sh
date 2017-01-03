#datapath=/home/uym2/simphy_root/simphy-uyen

for tree in `find $datapath -name $treename | sort`; do
	echo $tree
	FastRoot.py -i $tree\_randroot -m MP -o `dirname $tree`/$treename\_MP -f `dirname $tree`/$treename\_MP_info.txt
done

		
for tree in `find $datapath -name $treename | sort`; do
	echo $tree
	FastRoot.py -i $tree\_ogrm_randroot -m MP -o `dirname $tree`/$treename\_ogrm_MP -f `dirname $tree`/$treename\_ogrm_MP_info.txt
done	
