library(phybase)

#Modified phybase version to work with trees that have numbers in their name
#Modified for this specific use without the option of no-parsing tip labels (integers are considered labels here)
my.read.tree.nodes=function (str, name = "") 
{
    str <- gsub("\\[.*\\]", "", str)
    nobrlens <- 0
    if (length(grep(":", str)) == 0) {
        nobrlens <- 1
        str <- gsub(",", ":1.0,", str)
        str <- gsub(")", ":1.0)", str)
        str <- gsub(";", ":1.0;", str)
    }
    string <- unlist(strsplit(str, NULL))
    leftpar <- which(string == "(")
    rightpar <- which(string == ")")
    if (length(leftpar) != length(leftpar)) 
        stop("The number of left parenthesis is NOT equal to the number of right  parenthesis")
    speciesname <- sort(species.name(str))
    nspecies <- length(speciesname)
    {
        if (length(leftpar) == (nspecies - 1)) 
            rooted <- TRUE
        else if (length(leftpar) == (nspecies - 2)) 
            rooted <- FALSE
        else stop("The number of comma in the tree string is wrong!")
    }
    if (length(name) > 1 & (nspecies != length(name))) 
        stop("Wrong number of species names!")
    if (length(name) > 1) 
        speciesname <- name
    {
        if (rooted) 
            nNodes <- 2 * nspecies - 1
        else nNodes <- 2 * nspecies - 2
        nodes <- matrix(-9, nrow = nNodes, ncol = 7)
    }
    str1 <- str
    if (!length(grep("^[1-9]*$", speciesname, ignore.case = TRUE,perl=TRUE))) ##Improved here. Only integers do not need to be converted. It assumed [a-z]* leaves
    	str1 <- name2node(str1, speciesname)
    father <- nspecies + 1
    while (father < (nNodes + 1)) {
        string <- unlist(strsplit(str1, NULL))
        leftpar <- which(string == "(")
        rightpar <- which(string == ")")
        colon <- which(string == ":")
        {
            if (length(leftpar) == 1) 
                substr <- paste(string[leftpar[sum(leftpar < 
                  rightpar[1])]:rightpar[1]], sep = "", collapse = "")
            else substr <- paste(string[leftpar[sum(leftpar < 
                rightpar[1])]:(colon[which(colon > rightpar[1])[1]] - 
                1)], sep = "", collapse = "")
        }
        substring <- unlist(strsplit(substr, NULL))
        colon <- which(substring == ":")
        comma <- which(substring == ",")
        pound <- which(substring == "#")
        percent <- which(substring == "%")
        combine <- which(substring == "," | substring == ")" | 
            substring == "#" | substring == "%")
        node1 <- as.integer(paste(substring[2:(colon[1] - 1)], 
            sep = "", collapse = ""))
        node2 <- as.integer(paste(substring[(comma[1] + 1):(colon[2] - 
            1)], sep = "", collapse = ""))
        if (length(comma) > 1) 
            node3 <- as.integer(paste(substring[(comma[2] + 1):(colon[3] - 
                1)], sep = "", collapse = ""))
        if (length(colon) == 0) {
            node1Branch <- -9
            node2Branch <- -9
        }
        if (length(colon) > 0) {
            x1 <- combine[sum(combine < colon[1]) + 1] - 1
            x2 <- combine[sum(combine < colon[2]) + 1] - 1
            if (length(colon) == 3) {
                x3 <- combine[sum(combine < colon[3]) + 1] - 
                  1
                nodes[node3, 4] <- as.double(paste(substring[(colon[3] + 
                  1):x3], sep = "", collapse = ""))
            }
            node1Branch <- as.double(paste(substring[(colon[1] + 
                1):x1], sep = "", collapse = ""))
            node2Branch <- as.double(paste(substring[(colon[2] + 
                1):x2], sep = "", collapse = ""))
        }
        if (length(percent) == 0) {
            node1mu <- -9
            node2mu <- -9
        }
        if (length(percent) == 1) {
            if (percent[1] < comma[1]) {
                node1mu <- as.double(paste(substring[(percent[1] + 
                  1):(comma[1] - 1)], sep = "", collapse = ""))
                node2mu <- -9
            }
            else {
                node2mu <- as.double(paste(substring[(percent[1] + 
                  1):(length(substring) - 1)], sep = "", collapse = ""))
                node1mu <- -9
            }
        }
        if (length(percent) == 2) {
            node1mu <- as.double(paste(substring[(percent[1] + 
                1):(comma[1] - 1)], sep = "", collapse = ""))
            node2mu <- as.double(paste(substring[(percent[2] + 
                1):(length(substring) - 1)], sep = "", collapse = ""))
        }
        if (length(percent) == 3) {
            node1mu <- as.double(paste(substring[(percent[1] + 
                1):(comma[1] - 1)], sep = "", collapse = ""))
            node2mu <- as.double(paste(substring[(percent[2] + 
                1):(comma[2] - 1)], sep = "", collapse = ""))
            node3mu <- as.double(paste(substring[(percent[3] + 
                1):(length(substring) - 1)], sep = "", collapse = ""))
            nodes[node3, 5] <- node3mu
        }
        if (length(percent) == 0) {
            if (length(pound) == 0) {
                node1theta <- -9
                node2theta <- -9
            }
            if (length(pound) == 1) {
                if (pound[1] < comma[1]) {
                  node1theta <- as.double(paste(substring[(pound[1] + 
                    1):(comma[1] - 1)], sep = "", collapse = ""))
                  node2theta <- -9
                }
                else {
                  node2theta <- as.double(paste(substring[(pound[1] + 
                    1):(length(substring) - 1)], sep = "", collapse = ""))
                  node1theta <- -9
                }
            }
            if (length(pound) == 2) {
                node1theta <- as.double(paste(substring[(pound[1] + 
                  1):(comma[1] - 1)], sep = "", collapse = ""))
                node2theta <- as.double(paste(substring[(pound[2] + 
                  1):(length(substring) - 1)], sep = "", collapse = ""))
            }
            if (length(pound) == 3) {
                node1theta <- as.double(paste(substring[(pound[1] + 
                  1):(comma[1] - 1)], sep = "", collapse = ""))
                node2theta <- as.double(paste(substring[(pound[2] + 
                  1):(comma[2] - 1)], sep = "", collapse = ""))
                node3theta <- as.double(paste(substring[(pound[3] + 
                  1):(length(substring) - 1)], sep = "", collapse = ""))
                nodes[node3, 5] <- node3theta
            }
        }
        if (length(percent) > 0) {
            if (length(pound) == 0) {
                node1theta <- -9
                node2theta <- -9
            }
            if (length(pound) == 1) {
                if (pound[1] < comma[1]) {
                  node1theta <- as.double(paste(substring[(pound[1] + 
                    1):(percent[1] - 1)], sep = "", collapse = ""))
                  node2theta <- -9
                }
                else {
                  node2theta <- as.double(paste(substring[(pound[1] + 
                    1):(percent[2] - 1)], sep = "", collapse = ""))
                  node1theta <- -9
                }
            }
            if (length(pound) == 2) {
                node1theta <- as.double(paste(substring[(pound[1] + 
                  1):(percent[1] - 1)], sep = "", collapse = ""))
                node2theta <- as.double(paste(substring[(pound[2] + 
                  1):(percent[2] - 1)], sep = "", collapse = ""))
            }
            if (length(pound) == 3) {
                node1theta <- as.double(paste(substring[(pound[1] + 
                  1):(percent[1] - 1)], sep = "", collapse = ""))
                node2theta <- as.double(paste(substring[(pound[2] + 
                  1):(percent[2] - 1)], sep = "", collapse = ""))
                node3theta <- as.double(paste(substring[(pound[3] + 
                  1):(percent[3] - 1)], sep = "", collapse = ""))
                nodes[node3, 5] <- node3theta
            }
        }
        nodes[node1, 1] <- father
        nodes[node1, 4] <- node1Branch
        nodes[node1, 5] <- node1theta
        nodes[node1, 6] <- node1mu
        nodes[node2, 1] <- father
        nodes[node2, 4] <- node2Branch
        nodes[node2, 5] <- node2theta
        nodes[node2, 6] <- node2mu
        if (length(comma) > 1) {
            nodes[node3, 1] <- father
            nodes[father, 4] <- node3
        }
        nodes[father, 2] <- node1
        nodes[father, 3] <- node2
        rightpar1 <- which(substring == ")")
        if (rightpar1 < length(substring)) {
            postprob <- paste(substring[(rightpar1 + 1):length(substring)], 
                sep = "", collapse = "")
            nodes[father, 7] <- as.numeric(postprob)
        }
        substr <- gsub("[(]", "[(]", substr)
        substr <- gsub("[)]", "[)]", substr)
        substr <- gsub("\\+", "", substr)
        str1 <- gsub("\\+", "", str1)
        str1 <- gsub(substr, father, str1)
        father <- father + 1
    }
    if (length(grep("%", str1))) 
        nodes[nNodes, 6] <- as.double(gsub(";", "", gsub(".*\\%", 
            "", str1)))
    if (length(grep("#", str1))) {
        if (length(grep("%", str1))) 
            nodes[nNodes, 5] <- as.double(gsub(".*\\#", "", gsub("\\%.*", 
                "", str1)))
        else nodes[nNodes, 5] <- as.double(gsub(";", "", gsub(".*\\#", 
            "", str1)))
    }
    if (!rooted) 
        nodes[nNodes, 1] <- -8
    if (nobrlens == 1) 
        nodes[, 4] <- -9
    z <- list(nodes = matrix(0, nNodes, 5), names = "", root = TRUE)
    z$nodes <- nodes
    z$names <- speciesname
    z$root <- rooted
    z
}

##Replacament of read.tree.nodes of the phybase package for the steac and star methods
unlockBinding("read.tree.nodes", as.environment("package:phybase"))
assignInNamespace("read.tree.nodes", my.read.tree.nodes, ns="phybase", envir="package:phybase");
assign("read.tree.nodes", my.read.tree.nodes, "package:phybase") 

#NJST functions
nancdist<-function(tree, taxaname)
{
	ntaxa<-length(taxaname)
	nodematrix<-my.read.tree.nodes(tree,taxaname)$nodes
	if(is.rootedtree(nodematrix)) nodematrix<-unroottree(nodematrix)
	dist<-matrix(0, ntaxa,ntaxa)
	for(i in 1:(ntaxa-1))
		for(j in (i+1):ntaxa)
		{
		anc1<-ancestor(i,nodematrix)
		anc2<-ancestor(j,nodematrix)
		n<-sum(which(t(matrix(rep(anc1,length(anc2)),ncol=length(anc2)))-anc2==0, arr.ind=TRUE)[1,])-3
		if(n==-1) n<-0
		dist[i,j]<-n
		}
	dist<-dist+t(dist)
	z<-list(dist=as.matrix, taxaname=as.vector)
	z$dist<-dist
	z$taxaname<-taxaname
	z
}

njst.sptree<-function(genetrees, spname, taxaname, species.structure)
{

	ntree<-length(genetrees) #gets number of trees
	ntaxa<-length(taxaname) #gets number of tips
	dist <- matrix(0, nrow = ntree, ncol = ntaxa * ntaxa) #distance matrix
	
	for(i in 1:ntree) #gtrees' loop
	{
		genetree1 <- my.read.tree.nodes(genetrees[i]) #tree object
        	thistreetaxa <- genetree1$names #tip's labels, ordered like in sort(as.character(leaves))
        	ntaxaofthistree <- length(thistreetaxa) #number of leaves
        	thistreenode <- rep(-1, ntaxaofthistree) # vector of n_tips times -1
		dist1<-matrix(0,ntaxa,ntaxa)#distance matrix for this tree
        	for (j in 1:ntaxaofthistree) 
		{ 
            		thistreenode[j] <- which(taxaname == thistreetaxa[j]) #fills the vector thistreenode[j] with the position of each node name in the general taxaname vector (leaveset)
            		if (length(thistreenode[j]) == 0) 
			{
                		print(paste("wrong taxaname", thistreetaxa[j],"in gene", i))
                		return(0)
            		}
        	}
		dist1[thistreenode, thistreenode]<-nancdist(genetrees[i],thistreetaxa)$dist
		dist[i,]<-as.numeric(dist1)
	}

	dist[dist == 0] <- NA
    	dist2 <- matrix(apply(dist, 2, mean, na.rm = TRUE), ntaxa, ntaxa)
    	diag(dist2) <- 0
    	if (sum(is.nan(dist2)) > 0) 
	{
        	print("missing species!")
        	dist2[is.nan(dist2)] <- 10000
    	}
    	speciesdistance <- pair.dist.mulseq(dist2, species.structure)

	tree<-write.tree(nj(speciesdistance))
	#node2name(tree,name=spname)
}
#My code
args=commandArgs(trailingOnly=TRUE)

if (length(args)!=5 || !(args[1] == "steac" || args[1] == "star" || args[1] == "njst"))
{ 
print("Usage: script method treefile mapfile outgroup outfile")
print(length(args))
quit()
}

#originaltrees=read.tree("../bestml/alltrees.rooted")
#write.tree(originaltrees,"gtrees")

treefile=read.tree.string(args[2],format="phylip")
trees=treefile$tree
#g_names=treefile$names
outgroup=args[4]
s_map=read.table(args[3])
species.structure=table(s_map$V2,s_map$V1)
s_names=rownames(species.structure)
g_names=colnames(species.structure)

#s_names=read.table(pipe("cat ../bestml/species.list | awk '{print $1}'")) #first column
#s_names=s_names[,1] #From data.frame to vector

#ind_per_sp=(length(g_names)-1)/(length(s_names)-1) #0 is the outgroup, with only one replicate, the rest have the same number of individuals per species

#species.structure= matrix(0, nrow = length(s_names), ncol= length(g_names))
#for (i in 1:length(g_names))
#{
#	species=regmatches(g_names[i],regexpr("(?<=s)[0-9]+",g_names[i],perl=TRUE))
#	row=which(s_names == species)
#	species.structure[row,i]=1
#}

if (args[1]== "steac") {
outtree=steac.sptree(trees, s_names, g_names,species.structure,outgroup,method="nj")
} else if (args[1]== "star"){
print(s_names)
print(g_names)
print(species.structure)
print(outgroup)
outtree=star.sptree(trees, s_names, g_names,species.structure,outgroup,method="nj")
} else {
outtree=njst.sptree(trees, s_names, g_names,species.structure)
}
write.tree.string(outtree, format = "Phylip", file = args[5])
