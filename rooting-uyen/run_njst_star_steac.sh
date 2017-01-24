#!/bin/bash

#module load R/3.2.2_1

method=$1
genetrees=$2
s_tree=$3 # species tree (output)

gtre_fixed=`mktemp "tre-XXXXX"`
# fix input trees (taxon name starts with 'S' and all polotomies resolved)
fix_tree_for_mpest.sh $genetrees $gtre_fixed 

gtre_dmog=`mktemp "tre-XXXXX"`
add_dmog_w_lengths.sh $gtre_fixed D00 $gtre_dmog 

# create map file (map species names and genetrees' taxa)
species=`mktemp "species-XXXXX"`
head -n 1 $gtre_dmog | nw_labels -I - > $species

map=`mktemp "map-XXXXX"`
while read line; do
        echo $line $line
done < $species > $map

#call Rscript (the main part is here!)
Rscript steac_star_njst.r $method $gtre_dmog $map D00 $s_tree

#remove dummy outgroup from s_tree
outtre=`mktemp "tre-XXXXX"`
nw_prune $s_tree D00 > $outtre
mv $outtre $s_tree

#remove the fixed letter, in our case 'S' (added to genetrees while fixing them)
sed -i 's/S//g' $s_tree

rm $species $map $gtre_fixed $gtre_dmog
