# !/bin/bash

path=$1
treename=$2
jobfile=$3

for tree in `find $path -name $treename | sort`; do
	echo rooting_job.sh $tree
done > $jobfile

