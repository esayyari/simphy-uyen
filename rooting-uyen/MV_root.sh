datapath=/home/uym2/simphy_root/simphy-uyen

#for tree in `find $datapath -name truegenetrees_randroot | sort`; do
#	echo $tree
#	FastRoot.py -i $tree -m MV -o `dirname $tree`/truegenetrees_MV -f `dirname $tree`/truegenetrees_MV_info.txt
#done	


for tree in `find $datapath -name truegenetrees_ogrm_randroot | sort`; do
	echo $tree
	FastRoot.py -i $tree -m MV -o `dirname $tree`/truegenetrees_ogrm_MV -f `dirname $tree`/truegenetrees_ogrm_MV_info.txt
done	

