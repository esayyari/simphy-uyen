# !/bin/bash

intrees=$1

cat $intrees | sed -e 's/\([,(]\)\([0-9][0-9]*\)/\1S\2/g'
