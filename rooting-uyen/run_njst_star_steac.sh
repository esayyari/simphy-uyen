#!/bin/bash

#module load R/3.2.2_1

genetrees=$1
s_tree=$2 # species tree (output)
method=$3

# create map file (map species names and genetrees' taxa)
tmp_map=`mktemp map-XXXXX`
cat $genetrees |sed -e "s/:[^),]*//g" -e "s/)[0-9.]*//g" -e "s/[(,);]/ /g" -e 's/ /\'$'\n''/g' |sort|uniq|tail -n+2|sed "s/\(.*\)\_.*\_.*$/& s\1/" > $tmp_map

#call Rscript (the main dish is here!)
Rscript steac_star_njst.r $method $genetrees $tmp_map "0_0_0" $s_tree

rm $tmp_map
