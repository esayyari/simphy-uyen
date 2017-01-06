tree=$1

cd `dirname $tree`

# reroot at outgroup
nw_reroot $tree\_randroot 0 > $tree\_OG 

# remove the outgroup
nw_prune $tree\_OG 0 > $tree\_ogrm_OG

# get tree topology (remove branch length)
nw_topology $tree\_labeled > $tree\_topology

# compute "no. branches" distances
nw_distance $tree\_topology 0 | numlist -sub1 | numlist -avg > br2trueRoot_OG.txt
cp br2trueRoot_OG.txt br2trueRoot_ogrm_OG.txt # the same root no matter if you include the outgroup or not

# compute triplet distances
evalTrees_dtrpl.sh $tree\_labeled $tree\_OG > dtrpl_OG.txt
evalTrees_dtrpl.sh $tree\_ogrm $tree\_ogrm_OG > dtrpl_ogrm_OG.txt
