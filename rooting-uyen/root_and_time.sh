#! /bin/bash

trein=$1
treout=$2
meth=$3
log=$4

{ time FastRoot.py -i $trein -m $meth -o $treout; } 2> $log
