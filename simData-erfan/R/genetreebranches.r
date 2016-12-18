d<-read.csv('../outgroup-err.csv',sep='',header=FALSE)
d$V2<-as.numeric(d$V2)
d$V1<-as.factor(d$V1)
names(d) <-c("outToInRatio","GeneHeter","SpeciesHeter","rep","correctlyPlaced")
d$missPlaced <- (500 - d$correctlyPlaced)/500
d$correctlyPlacedR <- d$correctlyPlaced/500
d$rep <-as.factor(d$rep)
stat_ecdf(geom = "step")

ggplot(data=d[d$outToInRatio %in% c(1),],aes(correctlyPlacedR,color=as.factor(SpeciesHeter)))+stat_ecdf(geom = "step")+
  theme_bw()+theme(legend.position="bottom",
                   strip.background = element_blank(),strip.text.x = element_blank())+
  xlab("ratio of correctly placed outgroup")+
  ylab("percent of replicates")+
  #facet_wrap(~SpeciesHeter)+
  scale_color_brewer(name="",palette="Dark2")+
  scale_y_continuous(labels = percent)
ggsave('rooting_Outgroup_correctlyPlacedR-ecdf-outGroupToIngroup.1.Gene-by-lineage-specific-rate-heterogeneity-varies.pdf')



ggplot(data=d[d$GeneHeter %in% c(1.5),],aes(correctlyPlacedR,color=as.factor(outToInRatio)))+stat_ecdf(geom = "step")+
  theme_bw()+theme(legend.position="bottom",
                   strip.background = element_blank(),strip.text.x = element_blank())+
  xlab("ratio of correctly placed outgroup")+
  ylab("percent of replicates")+
  #facet_wrap(~outToInRatio)+
  scale_color_brewer(name="",palette="Dark2")+
  scale_y_continuous(labels = percent)
ggsave('rooting_correctlyPlacedR-density-outGroupToIngroup-varies.Gene-by-lineage-specific-rate-heterogeneity1.5.pdf')



d<-read.csv('../quartetscore.csv',sep='',header=FALSE)

ggplot(data=d[d$V1 %in% c(0,1),],aes(V5,fill=as.factor(V3)))+
  geom_density(aes(x=V5,y=..density..),alpha=0.5, adjust=1.2,position="dodge")+
  theme_bw()+theme(legend.position="bottom",
                   strip.background = element_blank())+
  xlab('ASTRAL quartet Score')+
  scale_fill_brewer(name="GeneBylineage heterogeneity",palette="Dark2")+
  facet_wrap(~V1)
ggsave('rooting_quartet_score-density-outGroupToIngroup.0.or.1.Gene-by-lineage-specific-rate-heterogeneity-varies.pdf')



ggplot(data=d[d$V3 %in% c(1.5),],aes(V5,fill=as.factor(V1)))+
  geom_density(alpha=0.5, adjust=1.2,position="dodge")+
  theme_bw()+theme(legend.position="bottom",
                   strip.background = element_blank())+
  xlab('ASTRAL quartet Score')+
  scale_fill_brewer(name="Ratio ingroup to root-to-ingroup-branch",palette="Dark2")+
  facet_wrap(~V3)
ggsave('rooting_quartet_score-density-all-in-one-outGroupToIngroup-varies.Gene-by-lineage-specific-rate-heterogeneity1.5.pdf')

ggplot(data=d[d$V3 %in% c(1.5),],aes(V5,fill=as.factor(V1)))+
  geom_density(alpha=0.5, adjust=1.2,position="dodge")+
  theme_bw()+theme(legend.position="bottom",
                   strip.background = element_blank())+
  xlab('ASTRAL quartet Score')+
  scale_fill_brewer(name="Ratio ingroup to root-to-ingroup-branch",palette="Dark2")+
  facet_wrap(~V1)
ggsave('rooting_quartet_score-density-outGroupToIngroup-varies.Gene-by-lineage-specific-rate-heterogeneity1.5.pdf')



ggplot(data=d,aes(x=V2,y=..density..*0.05*100,fill=V1))+geom_histogram(alpha=0.5, binwidth=0.05,position='identity')+
  theme_bw()+theme(legend.position="bottom",
                   strip.background = element_blank(),strip.text.x = element_blank())+facet_wrap(~V1)+
  xlab('ASTRAL quartet Score')+ylab('Percentage of data in each ASTRAL quartet score bin')+
  scale_fill_brewer(name="",palette="Dark2")
recast(d,V1~.,fun.aggregate=function(x) paste0(format(quantile(x)),collapse = '',sep=" "))
ggsave('ASTRAL_quartet_score-histogram.pdf')

d<-read.csv('../rf-true-vs-sp.csv',sep='',header=FALSE)
ggplot(data=d[],aes(V5))+geom_density(alpha=0.5, adjust=1.4,position="dodge",fill='red')+
  theme_bw()+theme(legend.position="bottom",
                   strip.background = element_blank(),strip.text.x = element_blank())+
  xlab('RF distance between species tree and gene trees')
ggsave('simphy-RF-sp-gt.pdf')

ggplot(data=d[],aes(x=V5,y=..count../sum(..count..),fill='red'))+geom_histogram(alpha=0.5, binwidth=0.05,position="dodge",fill='red')+
  theme_bw()+theme(legend.position="bottom",
                   strip.background = element_blank(),strip.text.x = element_blank())+
  xlab('RF distance between species tree and gene trees')+ylab('fraction of data in each RF distance bin')
ggsave('simphy-RF-sp-gt-hist.pdf')
