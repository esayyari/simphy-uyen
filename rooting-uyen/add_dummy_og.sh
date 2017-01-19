#! /bin/bash

intrees=$1
og=$2
outfile=$3

cat $intrees | sed -e "s/^/($og,/g" | sed -e "s/;/:1);/" > $outfile
