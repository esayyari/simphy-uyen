tree=$1

cd `dirname $tree`

# label
echo "Labeling ... "
[ -e $tree\_labeled ] && rm $tree\_labeled
LabelTree.py -i $tree -o $tree\_labeled

# remove outgroup
echo "Removing outgroup ... "
[ -e $tree\_ogrm ] && rm $tree\_ogrm
nw_prune $tree\_labeled 0 > $tree\_ogrm

# randomly reroot
echo "Randomly rooting ... "
r=$((RANDOM%30+1))
[ -e randroot.txt ] && rm randroot.txt
echo $r > randroot.txt
[ -e $tree\_randroot ] && rm $tree\_randroot
nw_reroot $tree\_labeled $r > $tree\_randroot


r=$((RANDOM%30+1))
[ -e ogrm_randroot.txt ] && rm ogrm_randroot.txt
echo $r > ogrm_randroot.txt
[ -e $tree\_ogrm_randroot ] && rm $tree\_ogrm_randroot
nw_reroot $tree\_ogrm $r > $tree\_ogrm_randroot


# MP_root
echo "MP rooting ..."
[ -e $tree\_MP ] && rm $tree\_MP
[ -e $tree\_MP_info.txt ] && rm $tree\_MP_info.txt
root_multi.sh $tree\_randroot MP $tree\_MP $tree\_MP_info.txt 

[ -e $tree\_ogrm_MP ] && rm $tree\_ogrm_MP
[ -e $tree\_ogrm_MP_info.txt ] && rm $tree\_ogrm_MP_info.txt
root_multi.sh $tree\_ogrm_randroot MP $tree\_ogrm_MP $tree\_ogrm_MP_info.txt 

# MV_root
echo "MV rooting ..."
[ -e $tree\_MV ] && rm $tree\_MV
[ -e $tree\_MV_info.txt ] && rm $tree\_MV_info.txt
root_multi.sh $tree\_randroot MV $tree\_MV $tree\_MV_info.txt 

[ -e $tree\_ogrm_MV ] && rm $tree\_ogrm_MV
[ -e $tree\_ogrm_MV_info.txt ] && rm $tree\_ogrm_MV_info.txt
root_multi.sh $tree\_ogrm_randroot MV $tree\_ogrm_MV $tree\_ogrm_MV_info.txt 

# eval
echo "Evaluating ..."
evalTrees_rmse.sh $tree $tree\_MP > rmse_MP.txt
evalTrees_rmse.sh $tree $tree\_MV > rmse_MV.txt
evalTrees_rmse.sh $tree\_ogrm $tree\_ogrm_MP > rmse_MP_ogrm.txt
evalTrees_rmse.sh $tree\_ogrm $tree\_ogrm_MV > rmse_MV_ogrm.txt

evalTrees_d2trueroot.sh $tree\_MP_info.txt $tree\_labeled randroot.txt > d2trueRoot_MP.txt
evalTrees_d2trueroot.sh $tree\_MV_info.txt $tree\_labeled randroot.txt > d2trueRoot_MV.txt
evalTrees_d2trueroot.sh $tree\_ogrm_MP_info.txt $tree\_ogrm ogrm_randroot.txt > d2trueRoot_ogrm_MP.txt
evalTrees_d2trueroot.sh $tree\_ogrm_MV_info.txt $tree\_ogrm ogrm_randroot.txt > d2trueRoot_ogrm_MV.txt
