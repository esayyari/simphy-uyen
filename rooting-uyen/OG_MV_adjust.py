# ! /usr/bin/env python
import sys

infile=sys.argv[1]

theta = 1.75
with open(infile,'r') as f:
	for line in f:
		std_OG,std_MV,dtrpl_OG,dtrpl_MV = [ float(x) for x in line.split() ]
		if std_MV == 0:
			print(dtrpl_OG)
		else:
			r = std_OG/std_MV
			if r > theta:
				print(dtrpl_MV)
			else:
				print(dtrpl_OG)
