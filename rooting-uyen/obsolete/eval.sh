# !/bin/bash
#datapath=/home/uym2/simphy_root/simphy-uyen

for tree in `find $datapath -name $treename | sort`; do
	echo $tree
	treepath=`dirname $tree`
	#./evalTrees_rmse.sh $tree\_labeled $tree\_MP > $treepath/rmse_MP.txt
	#./evalTrees_rmse.sh $tree\_labeled $tree\_MV > $treepath/rmse_MV.txt
	./evalTrees_rmse.sh $tree\_ogrm $tree\_ogrm_MP > $treepath/rmse_MP_ogrm.txt
	./evalTrees_rmse.sh $tree\_ogrm $tree\_ogrm_MV > $treepath/rmse_MV_ogrm.txt
done


for d in `ls $datapath`; do
	#cat $datapath/$d/*/*/rmse_MP.txt | numlist -avg > $datapath/$d/rmse_MP_summary.txt
	#cat $datapath/$d/*/*/rmse_MV.txt | numlist -avg > $datapath/$d/rmse_MV_summary.txt
	cat $datapath/$d/*/*/rmse_MP_ogrm.txt | numlist -avg > $datapath/$d/rmse_MP_ogrm_summary.txt
	cat $datapath/$d/*/*/rmse_MV_ogrm.txt | numlist -avg > $datapath/$d/rmse_MV_ogrm_summary.txt
done
