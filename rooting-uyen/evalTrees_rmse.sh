# !/bin/bash

ref=$1
targ=$2

while IFS=$'\t' read -r f1 f2; do echo $f1 > temp1; echo $f2 > temp2; ./dleaf_rmse.sh temp1 temp2; done < <(paste $ref $targ) | numlist -avg

rm temp1 temp2
