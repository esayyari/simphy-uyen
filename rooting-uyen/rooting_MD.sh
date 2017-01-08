tree=$1

cd `dirname $tree`

echo "MD rooting ..."
[ -e $tree\_MD ] && rm $tree\_MD
[ -e $tree\_MD_info.txt ] && rm $tree\_MD_info.txt
root_multi.sh $tree\_randroot MD $tree\_MD $tree\_MD_info.txt 

echo "MD rooting ogrm ..."
[ -e $tree\_ogrm_MD ] && rm $tree\_ogrm_MD
[ -e $tree\_ogrm_MD_info.txt ] && rm $tree\_ogrm_MD_info.txt
root_multi.sh $tree\_ogrm_randroot MD $tree\_ogrm_MD $tree\_ogrm_MD_info.txt 

