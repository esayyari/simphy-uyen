# !/bin/bash

# compute averaged triplet distance

truetrees=$1
estimatedtrees=$2

while read tt && read -u 3 et; do 
	echo $tt > true.tre
	echo $et > estimated.tre
	perl -pi -e 'chomp if eof' true.tre
	perl -pi -e 'chomp if eof' estimated.tre
	quart_bin calcTripDist true.tre estimated.tre
done < $truetrees 3< $estimatedtrees | numlist -avg

rm true.tre estimated.tre
