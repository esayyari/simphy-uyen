# !/bin/bash

ref_tree=$1
est_tree=$2
SPRDist -T $ref_tree $est_tree | grep "rSPR distance" | awk -F ' = ' '{print $2;}'
