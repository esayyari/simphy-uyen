path_true=$1
tree=$2
path_out=$3
method=$4
subsize=$5

path_est=`dirname $tree`

#temp=`mktemp -d`
#cd $temp

echo subsizing ...
head -n $subsize $tree > my_tree

echo running star ...
./run_njst_star_steac.sh star my_tree stree

echo rooting ...
nw_reroot stree 0 > stree_rooted

echo computing score ...
dtrpl_norm.sh $path_true/s_tree.trees stree_rooted > dtrpl_sub$subsize\_star_$method
dquart_norm.sh $path_true/s_tree.trees stree_rooted > dqrt_sub$subsize\_star_$method

cp stree_rooted $path_out/star.$method\_$subsize
cp dtrpl_sub$subsize\_star_$method $path_out/dtrpl_sub$subsize\_star_$method
cp dqrt_sub$subsize\_star_$method $path_out/dqrt_sub$subsize\_star_$method

#rm -r $temp
