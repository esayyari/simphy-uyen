#! /usr/bin/env python

from dendropy import Tree
from sys import argv

file=argv[1]
outfile=argv[2]

a_tree = Tree.get_from_path(file,"newick")
a_tree.reroot_at_midpoint(update_bipartitions=True) 
a_tree.write_to_path(outfile,"newick")
