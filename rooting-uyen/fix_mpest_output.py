#! /usr/bin/env python
# fix the output of mpest: 0-->30 instead of 1-->31 (a not-so-good approach, but convenient)

import os
import sys
import dendropy
 
src_fpath = sys.argv[1]
dest_fpath = sys.argv[2]

tree = dendropy.Tree.get_from_path(src_fpath, "newick")

for node in tree.leaf_node_iter(): # doesn't work for some reasons >_<
#for node in tree.postorder_node_iter():
       #if node.is_leaf():
		node.taxon.label = str(int(node.taxon.label)-1);

tree.write_to_path(dest_fpath, "newick",suppress_rooting=True)
