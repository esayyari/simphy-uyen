# !/bin/bash

# compute averaged triplet distance

truetrees=$1
estimatedtrees=$2

while read tt && read -u 3 et; do 
	echo $tt > true.tre
	echo $et > estimated.tre
	dtrpl_norm.sh true.tre estimated.tre
done < $truetrees 3< $estimatedtrees

rm true.tre estimated.tre
