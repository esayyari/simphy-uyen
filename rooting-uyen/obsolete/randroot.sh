#datapath=/home/uym2/simphy_root/simphy-uyen

#for tree in `find $datapath -name $treename\_labeled | sort`; do
#	echo $tree
#	r=$((RANDOM%30+1))
#	echo $r > `dirname $tree`/randroot.txt
#	nw_reroot $tree $r > `dirname $tree`/$treename\_randroot
#done	



for tree in `find $datapath -name $treename\_ogrm | sort`; do
	echo $tree
	r=$((RANDOM%30+1))
	echo $r > `dirname $tree`/randroot_ogrm.txt
	nw_reroot $tree $r > `dirname $tree`/$treename\_ogrm_randroot
done	
