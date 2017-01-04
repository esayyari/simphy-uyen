tree=$1

# label
echo "Labeling ... "
LabelTree.py -i $tree -o $tree\_labeled

# remove outgroup
echo "Removing outgroup ... "
nw_prune $tree\_labeled 0 > $tree\_ogrm

# randomly reroot
echo "Randomly rooting ... "
r=$((RANDOM%30+1))
echo $r > `dirname $tree`/randroot.txt
nw_reroot $tree\_labeled $r > $tree\_randroot


r=$((RANDOM%30+1))
echo $r > `dirname $tree`/ogrm_randroot.txt
nw_reroot $tree\_ogrm $r > $tree\_ogrm_randroot


# MP_root
echo "MP rooting ..."
root_multi.sh $tree\_randroot MP $tree\_MP $tree\_MP_info.txt 
#FastRoot.py -i $tree\_randroot -m MP -o $tree\_MP -f $tree\_MP_info.txt
root_multi.sh $tree\_ogrm_randroot MP $tree\_ogrm_MP $tree\_ogrm_MP_info.txt 
#FastRoot.py -i $tree\_ogrm_randroot -m MP -o $tree\_ogrm_MP -f $tree\_ogrm_MP_info.txt

# MV_root
echo "MV rooting ..."
root_multi.sh $tree\_randroot MV $tree\_MV $tree\_MV_info.txt 
#FastRoot.py -i $tree\_randroot -m MV -o $tree\_MV -f $tree\_MV_info.txt
root_multi.sh $tree\_ogrm_randroot MV $tree\_ogrm_MV $tree\_ogrm_MV_info.txt 
#FastRoot.py -i $tree\_ogrm_randroot -m MV -o $tree\_ogrm_MV -f $tree\_ogrm_MV_info.txt

# eval
echo "Evaluating ..."
evalTrees_rmse.sh $tree $tree\_MP > `dirname $tree`/rmse_MP.txt
evalTrees_rmse.sh $tree $tree\_MV > `dirname $tree`/rmse_MV.txt
evalTrees_rmse.sh $tree\_ogrm $tree\_ogrm_MP > `dirname $tree`/rmse_MP_ogrm.txt
evalTrees_rmse.sh $tree\_ogrm $tree\_ogrm_MV > `dirname $tree`/rmse_MV_ogrm.txt

evalTrees_d2trueroot.sh $tree\_MP_info.txt $tree\_labeled `dirname $tree`/randroot.txt > `dirname $tree`/d2trueRoot_MP.txt
evalTrees_d2trueroot.sh $tree\_MV_info.txt $tree\_labeled `dirname $tree`/randroot.txt > `dirname $tree`/d2trueRoot_MV.txt
evalTrees_d2trueroot.sh $tree\_ogrm_MP_info.txt $tree\_ogrm `dirname $tree`/ogrm_randroot.txt > `dirname $tree`/d2trueRoot_ogrm_MP.txt
evalTrees_d2trueroot.sh $tree\_ogrm_MV_info.txt $tree\_ogrm `dirname $tree`/ogrm_randroot.txt > `dirname $tree`/d2trueRoot_ogrm_MV.txt
