setwd(dirname(sys.frame(1)$ofile))

d<-read.csv('../../data/gtError-simphy-uyen.csv1',sep=' ',header=F)
source("../R/setup.r");
d$V1<-as.factor(d$V1);
d$V2<-as.factor(d$V2);
d$V3<-as.factor(d$V3);
d$V4<-as.factor(d$V4);
d<-d[!(d$V7 %in% "-"),]
d$V6<-as.numeric(as.character(d$V6))
d$V7<-as.numeric(as.character(d$V7))
d$V8<-as.numeric(as.character(d$V8))
d$V9<-as.numeric(as.character(d$V9))
d$V10<-as.numeric(as.character(d$V10))
d$V11<-as.numeric(as.character(d$V11))
d$rf=as.numeric((d$V7+d$V10)/(d$V6+d$V9))
d.sum = summarySE(d,measurevar="rf",groupvars=c("V1","V2","V4","V5"),na.rm=T,conf.interval=.95)
d.sum$rf = as.numeric(d.sum$rf)
cdat <- ddply(d.sum, c("V1","V2","V4"), summarise, rating.mean=mean(rf))
cdat[,4]<-as.numeric(cdat[,4])

d$method<-paste(d$V2,d$V3,sep="-")
ggplot(data=d[d$V4 %in% "1.5",],aes(x=rf,color=V2))+geom_density()+
  theme_bw()+theme(legend.position = "bottom")+
  scale_color_brewer(name="Outgroup to Ingroup ratio",palette="Dark2")+
  xlab('RF distance (true vs estimated)')+facet_wrap(~V1)


ggplot(data=d,aes(x=method,y=rf,fill=method))+
  geom_boxplot()+facet_wrap(~V1)+scale_fill_brewer(name="",palette="BuPu")+
  theme_bw()+
    theme(legend.position = "bottom",
          axis.text.x = element_text(face="bold",angle=90))+
  scale_color_brewer(name="Method",palette="Dark2")+
  xlab('Method')+facet_wrap(~V1)+ylab('RF distance (true vs estimated)')
ggsave('geneTreeError.pdf',width=6.5,height=4)


  #geom_vline(data=cdat[d$V4 %in% "1.5",], 
  #aes(xintercept=rating.mean, color=V2),size=1,linetype="dashed")

d<-read.csv('../../data/compareSpVsGenes.score.csv1',sep=' ',header=F)
d$V1<-as.factor(d$V1);
d$V2<-as.factor(d$V2);
d$V3<-as.factor(d$V3);
d$V4<-as.factor(d$V4);
ggplot(data=d,aes(x=V8,color=V2,linetype=V4))+geom_density()+theme_bw()+
  facet_wrap(~V1)+scale_color_brewer(name="Outgroup to Ingroup ratio",palette="Dark2")


d$rf=as.numeric((d$V7+d$V10)/(d$V6+d$V9))
d.sum = summarySE(d,measurevar="rf",groupvars=c("V1","V2","V4","V5"),na.rm=T,conf.interval=.95)
d.sum$rf = as.numeric(d.sum$rf)
d.sum$rep=as.factor(interaction(d.sum$V5,as.numeric(d.sum$V4)))
cdat <- ddply(d.sum, c("V1","V2","V5"), summarise, rating.mean=mean(rf))
cdat[,4]<-as.numeric(cdat[,4])


d<-read.csv('../../data/outgroup-err.csv',sep=" ",header=F)

d$V1<-as.factor(d$V1);
d$V2<-as.factor(d$V2);
d$V3<-as.factor(d$V3);
d$V4<-as.factor(d$V4);
d$V6<-as.numeric(d$V6);
d$method<-paste(d$V2,d$V3,sep="-")

d<-read.csv('../../data/quartetscore.csv',sep=" ",header=F)
d$V1<-as.factor(d$V1);
d$V2<-as.factor(d$V2);
d$V3<-as.factor(d$V3);
d$V4<-as.factor(d$V4);
d$method<-paste(d$V2,d$V3,sep="-")
d$rat<-(d$V6-d$V7)/d$V6



ggplot(d[!(d$V2%in%"0"),], aes(x=rat,color=method)) + stat_ecdf(geom = "step") +
  scale_color_brewer(name="Method",palette="Dark2")+
  scale_y_continuous(labels = scales::percent)+xlab('Outgroup missplacement ratio')+
  ylab('Percent of replicates')+theme_bw()+theme(legend.position='bottom')+facet_wrap(~V1)
ggsave('outgroup_ecdf.pdf',height=4,width=6.5)



ggplot(data=d,aes(x=method,y=V6,fill=method))+
  geom_boxplot()+facet_wrap(~V1)+scale_fill_brewer(name="",palette="BuPu")+
  theme_bw()+
  theme(legend.position = "bottom",
        axis.text.x = element_text(face="bold",angle=90))+
  scale_color_brewer(name="Ingroup outgroup ratio-species/genes heterogenit",palette="Dark2")+ylab('QuartetScore')+
  xlab('RF distance (true vs estimated)')+facet_wrap(~V1)
ggsave('quartetScore.pdf',height=4,width=6)




