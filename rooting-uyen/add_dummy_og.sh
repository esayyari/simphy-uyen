#! /bin/bash

intrees=$1
og=$2
outfile=$3

cat $intrees | sed -e "s/^/(S$og,/g" | sed -e "s/;/);/" > $outfile
