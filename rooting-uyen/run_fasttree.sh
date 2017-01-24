#! /bin/bash

aln=$1
tre=$2

FastTreeMP -nt -gtr -gamma  $aln > $tre
