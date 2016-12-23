datapath=/home/uym2/simphy_root/simphy-uyen

#for tree in `find $datapath -name truegenetrees_labeled | sort`; do
#	echo $tree
#	r=$((RANDOM%30+1))
#	echo $r > `dirname $tree`/randroot.txt
#	nw_reroot $tree $r > `dirname $tree`/truegenetrees_randroot
#done	



for tree in `find $datapath -name truegenetrees_ogrm | sort`; do
	echo $tree
	r=$((RANDOM%30+1))
	echo $r > `dirname $tree`/randroot_ogrm.txt
	nw_reroot $tree $r > `dirname $tree`/truegenetrees_ogrm_randroot
done	
