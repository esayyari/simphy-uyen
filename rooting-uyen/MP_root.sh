datapath=/home/uym2/simphy_root/simphy-uyen

#for tree in `find $datapath -name truegenetrees_randroot | sort`; do
#	echo $tree
#	FastRoot.py -i $tree -m MP -o `dirname $tree`/truegenetrees_MP -f `dirname $tree`/truegenetrees_MP_info.txt
#done

	
for tree in `find $datapath -name truegenetrees_ogrm_randroot | sort`; do
	echo $tree
	FastRoot.py -i $tree -m MP -o `dirname $tree`/truegenetrees_ogrm_MP -f `dirname $tree`/truegenetrees_ogrm_MP_info.txt
done	
