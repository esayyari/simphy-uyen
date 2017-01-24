require(data.table)

setwd(dirname(sys.frame(1)$ofile))
getwd(getSrcFilename(function(x) {x}))
dpp<-read.csv("../polyTomyStat-final.csv",sep = ' ',header=F)
pdf('../figures/polytompy-Stat-simphy-100-density.pdf',compress=F)
ggplot(data=dpp,aes(V5,fill=V2))+geom_density(alpha=0.5,position='dodge',adjust=1.2)+theme_bw()+
  facet_wrap(~V2)
dev.off()

dpp$V1<-as.factor(dpp$V1)
dpp$V2<-as.factor(dpp$V2)
dpp$V3<-as.factor(dpp$V3)
dt <- data.table(dpp[dpp$V2 %in% "jc",])
dtt<-dt[,list(mean=mean(V5),numlargepoly=sum(V5>=0.5)/sum(V5>=0)*100),by=list(V1,V2)]
ggplot(data=dtt,aes(mean))+geom_density(alpha=0.5,adjust=1.2,fill='red')+facet_wrap(~V2)+theme_bw()
ggsave('mean-polytomy-per-replicate-simphy-100-density.pdf')
qplot(data=dtt,x=reorder(as.factor(V1),numlargepoly),y=numlargepoly,
      geom='point')+theme_bw()+xlab('replicate')+
  theme(axis.text.x = element_text(size=8,angle = 0, hjust = 0))+
  ylab('percent of gene trees 
       with more than half of the branches being polytomy')
ggsave('replicates_with_more_than_half_of_branches_polytomy.pdf')
