# !/bin/bash

refTree=$1
targTree=$2

nw_distance -n $refTree | sort | cut -f2 > t1
nw_distance -n $targTree | sort | cut -f2 > t2

paste t1 t2 | numlist -rmse

rm t1 t2
