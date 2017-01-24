tree=$1

cd `dirname $tree`

echo "MP2 rooting ..."
[ -e $tree\_MP2 ] && rm $tree\_MP2
[ -e $tree\_MP2_info.txt ] && rm $tree\_MP2_info.txt
root_multi.sh $tree\_randroot MP2 $tree\_MP2 $tree\_MP2_info.txt 

echo "MP2 rooting ogrm ..."
[ -e $tree\_ogrm_MP2 ] && rm $tree\_ogrm_MP2
[ -e $tree\_ogrm_MP2_info.txt ] && rm $tree\_ogrm_MP2_info.txt
root_multi.sh $tree\_ogrm_randroot MP2 $tree\_ogrm_MP2 $tree\_ogrm_MP2_info.txt 

