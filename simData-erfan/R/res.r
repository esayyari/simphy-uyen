setwd(dirname(sys.frame(1)$ofile))

d<-read.csv('../estimatedGenetrees.removed.csv',sep=' ',header=F)
source("../R/setup.r");
d$V1<-as.factor(d$V1);
d$V2<-as.factor(d$V2);
d$V3<-as.factor(d$V3);

d$rf=as.numeric((d$V7+d$V10)/(d$V6+d$V9))
d.sum = summarySE(d,measurevar="rf",groupvars=c("V1","V2","V4","V5"),na.rm=T,conf.interval=.95)
d.sum$rf = as.numeric(d.sum$rf)
d.sum$rep=as.factor(interaction(d.sum$V5,as.numeric(d.sum$V4)))
cdat <- ddply(d.sum, c("V1","V2","V5"), summarise, rating.mean=mean(rf))
cdat[,4]<-as.numeric(cdat[,4])

qplot(reorder(rf,rep),rf,
      data=d.sum[d.sum$V5 %in% c("jc") & d.sum$V1 %in% c(1), ],ylab="RF (true vs estimated gene trees)",
      xlab="replicates ordered by gene tree error",
      main="gene tree error for replicates of various model conditions")+
  facet_grid(V1~V2,scales="free_x")+
  geom_errorbar(aes(ymin=rf-sd, ymax=rf+sd),color="blue")+theme_bw()+
  th4+theme(plot.margin=unit(c(0,0,0,0),"mm"))
ggsave('estimated_vs_true_gene_trees-errorbar-outGroupToIngroup.1.Gene-by-lineage-specific-rate-heterogeneity-varies.pdf.pdf')


qplot(reorder(rf,rep),rf,
      data=d.sum[d.sum$V5 %in% c("jc") & d.sum$V1 %in% c(0), ],ylab="RF (true vs estimated gene trees)",
      xlab="replicates ordered by gene tree error",
      main="gene tree error for replicates of various model conditions")+
  facet_grid(V1~V2,scales="free_x")+
  geom_errorbar(aes(ymin=rf-sd, ymax=rf+sd),color="blue")+theme_bw()+
  th4+theme(plot.margin=unit(c(0,0,0,0),"mm"))
ggsave('estimated_vs_true_gene_trees-errorbar-outGroupToIngroup.0.Gene-by-lineage-specific-rate-heterogeneity-varies.pdf')

qplot(as.factor(reorder(rf,rep)),rf,
      data=d.sum[d.sum$V5 %in% c("jc") & d.sum$V2 %in% c(1.5), ],ylab="RF (true vs estimated gene trees)",
      xlab="replicates ordered by gene tree error",
      main="gene tree error for replicates of various model conditions")+
  facet_wrap(~V1)+
  geom_errorbar(aes(ymin=rf-sd, ymax=rf+sd),color="blue")+theme_bw()+
  th4+theme(plot.margin=unit(c(0,0,0,0),"mm"))
ggsave('estimated_vs_true_gene_trees-errorbart-outGroupToIngroup-varies.Gene-by-lineage-specific-rate-heterogeneity1.5.pdf')


ggplot(data=d[d$V1  %in% c(0,1),],aes(rf,fill=V2))+geom_density(alpha=0.5,adjust=2)+
  xlab("RF distance (true vs estimated)")+facet_wrap(~V1)+
  geom_vline(data=cdat[cdat$V1 %in% c(0,1),], aes(xintercept=rating.mean, colour=V2),size=1,linetype="dashed")+
  theme_bw()+scale_linetype_discrete(name="rate")+
 scale_x_continuous(labels=percent)+scale_fill_brewer(name="",palette="Dark2")+
  scale_color_brewer(name="",palette="Dark2")+
  ggtitle("Gene tree estimation error")
ggsave('estimated_vs_true_gene_trees-density-outGroupToIngroup.0.or.1.Gene-by-lineage-specific-rate-heterogeneity-varies.pdf')

ggplot(data=d[d$V2  %in% c(1.5),],aes(rf,fill=V1))+geom_density(alpha=0.5,adjust=2)+
  xlab("RF distance (true vs estimated)")+facet_grid(V5~V1)+
  geom_vline(data=cdat[cdat$V2 %in% c(1.5),], aes(xintercept=rating.mean, colour=V1),size=0.5,linetype="dashed")+
  theme_bw()+scale_linetype_discrete(name="rate")+
  scale_x_continuous(labels=percent)+scale_fill_brewer(name="",palette="Dark2")+
  scale_color_brewer(name="",palette="Dark2")+
  ggtitle("Gene tree estimation error")
ggsave('estimated_vs_true_gene_trees-density-outGroupToIngroup-varies.Gene-by-lineage-specific-rate-heterogeneity1.5.pdf')


ggplot(data=d[d$V2  %in% c(1.5),],aes(rf,fill=V1))+geom_density(alpha=0.5,adjust=2)+
  xlab("RF distance (true vs estimated)")+facet_wrap(~V5)+
  geom_vline(data=cdat[cdat$V2 %in% c(1.5),], aes(xintercept=rating.mean, colour=V1),size=0.5,linetype="dashed")+
  theme_bw()+scale_linetype_discrete(name="rate")+
  scale_x_continuous(labels=percent)+scale_fill_brewer(name="",palette="Dark2")+
  scale_color_brewer(name="",palette="Dark2")+
  ggtitle("Gene tree estimation error")
ggsave('estimated_vs_true_gene_trees-density-all-in-one-outGroupToIngroup-varies.Gene-by-lineage-specific-rate-heterogeneity1.5.pdf')

