# !/bin/bash

nleaves=$1

echo $(( $((nleaves-3))*$((nleaves-2))*$((nleaves-1))*$nleaves/24 ))
