#! /bin/bash

ref=$1
targ=$2

compareTrees.missingBranch $ref $targ | awk  '{print $3}'
