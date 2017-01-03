tree=$1

# label
LabelTree.py -i $tree -o $tree\_labeled

# remove outgroup
nw_prune $tree\_labeled 0 > $tree\_ogrm

# randomly reroot
r=$((RANDOM%30+1))
echo $r > `dirname $tree`/randroot.txt
nw_reroot $tree\_labeled $r > $tree\_randroot


r=$((RANDOM%30+1))
echo $r > `dirname $tree`/ogrm_randroot.txt
nw_reroot $tree\_ogrm $r > $tree\_ogrm_randroot


# MP_root
./root_multi.sh $tree\_randroot MP $tree\_MP $tree\_MP_info.txt 
#FastRoot.py -i $tree\_randroot -m MP -o $tree\_MP -f $tree\_MP_info.txt
./root_multi.sh $tree\_ogrm_randroot MP $tree\_ogrm_MP $tree\_ogrm_MP_info.txt 
#FastRoot.py -i $tree\_ogrm_randroot -m MP -o $tree\_ogrm_MP -f $tree\_ogrm_MP_info.txt

# MV_root
./root_multi.sh $tree\_randroot MV $tree\_MV $tree\_MV_info.txt 
#FastRoot.py -i $tree\_randroot -m MV -o $tree\_MV -f $tree\_MV_info.txt
./root_multi.sh $tree\_ogrm_randroot MV $tree\_ogrm_MV $tree\_ogrm_MV_info.txt 
#FastRoot.py -i $tree\_ogrm_randroot -m MV -o $tree\_ogrm_MV -f $tree\_ogrm_MV_info.txt

# eval
./evalTrees_rmse.sh $tree $tree\_MP > `dirname $tree`/rmse_MP.txt
./evalTrees_rmse.sh $tree $tree\_MV > `dirname $tree`/rmse_MV.txt
./evalTrees_rmse.sh $tree\_ogrm $tree\_ogrm_MP > `dirname $tree`/rmse_MP_ogrm.txt
./evalTrees_rmse.sh $tree\_ogrm $tree\_ogrm_MV > `dirname $tree`/rmse_MV_ogrm.txt
