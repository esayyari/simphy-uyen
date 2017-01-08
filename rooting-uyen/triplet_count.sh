# !/bin/bash

nleaves=$1

echo $(( $((nleaves-2))*$((nleaves-1))*$nleaves/6 ))
