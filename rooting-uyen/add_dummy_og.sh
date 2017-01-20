#! /bin/bash

intrees=$1
og=$2
outfile=$3

cat $intrees | sed -e "s/^/(S$og:0.05,/g" | sed -e "s/;/:0.05);/" > $outfile
