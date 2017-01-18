#! /usr/bin/env python
# fix the output of mpest: map the index to the actual name. Require map file

import os
import sys
import dendropy
 
src_fpath = sys.argv[1]
mapfile = sys.argv[2]
dest_fpath = sys.argv[3]

tree = dendropy.Tree.get_from_path(src_fpath, "newick")
sp_names=[]

with open(mapfile,"r") as f:
	for line in f:
		sp_names.append(line.rstrip())

for node in tree.leaf_node_iter():
		node.taxon.label = sp_names[int(node.taxon.label)-1];

tree.write_to_path(dest_fpath, "newick",suppress_rooting=True)
