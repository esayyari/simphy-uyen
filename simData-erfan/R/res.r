setwd(dirname(sys.frame(1)$ofile))
require('Cairo')
require('ggplot2')

d<-read.csv('../../data/gtError-simphy-uyen.csv1',sep=' ',header=F)
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
levels(d$V1)<-list("30-taxon"="31","2000-taxon"="2001","5000-taxon"="5001")
levels(d$V3)<-list("Low: α=5"="5","Medium: α=1.5"="1.5","High: α=0.15"="0.15")
cairo_pdf(file = 'geneTreeErrorDensity.pdf',width=10.5,height=3.3)
q<-ggplot(data=d[d$V2 %in% "1",],aes(x=rf,color=V3))+geom_density(adjust=2)+
  theme_bw()+theme(legend.position = "right",axis.text.y = element_text(face="bold"),
                   axis.text.x = element_text(face="bold"))+ylab("Density")+
  scale_color_brewer(name="Divergence from clock (α)",palette="Dark2")+
  xlab('RF distance (true vs estimated gene trees)')+facet_wrap(~V1)
print(q)
dev.off()



cairo_pdf(file = 'geneTreeErrorBoxPlot.pdf',width=9,height=4.2)

q<-ggplot(data=d[d$V3 %in% c("Medium: α=1.5"),],aes(x=V2,y=rf,fill=V2))+
  geom_boxplot(outlier.alpha=0.3,width=0.6)+facet_wrap(~V1)+
  scale_fill_brewer(name="Root to crown ratio",palette="BuPu")+
  theme_bw()+
    theme(legend.position = "bottom",axis.text.y = element_text(face="bold"),
          axis.text.x = element_text(face="bold"))+
  xlab('Root to crown ratio')+facet_wrap(~V1)+ylab('RF distance (true vs estimated gene trees)')
print(q)
dev.off()





d<-read.csv('../../data/outgroup-err.csv',sep=" ",header=F)

d$V1<-as.factor(d$V1);
d$V2<-as.factor(d$V2);
d$V3<-as.factor(d$V3);
d$V4<-as.factor(d$V4);
d$V6<-as.numeric(d$V6);
levels(d$V1)<-list("30-taxon"="31","2000-taxon"="2001","5000-taxon"="5001")
levels(d$V3)<-list("Low: α=5"="5","Medium: α=1.5"="1.5","High: α=0.15"="0.15")

d$rat<-(d$V6-d$V7)/d$V6


cairo_pdf(file = 'outgroup_ecdf.pdf',height=4.5,width=9)

q<-ggplot(d[!(d$V2%in%"0"),], aes(x=rat,color=V2,linetype=V3)) + stat_ecdf() +
  scale_color_brewer(name="Root to crown ratio",palette="Dark2")+
  scale_linetype_manual(values = c("dashed","solid","dotted"),name="Divergence from clock (α)")+
  scale_y_continuous(labels = scales::percent)+xlab('portion of genes with ingroup/outgroup mixing')+
  ylab('Percent of replicates')+theme_bw()+
  theme(legend.position="bottom",legend.box = "vertical",axis.text.y = element_text(face="bold"),
        axis.text.x = element_text(face="bold"))+facet_wrap(~V1)
print(q)
dev.off()

d<-read.csv('../../data/quartetscore.csv',sep=" ",header=F)
d$V1<-as.factor(d$V1);
d$V2<-as.factor(d$V2);
d$V3<-as.factor(d$V3);
d$V4<-as.factor(d$V4);
levels(d$V1)<-list("30-taxon"="31","2000-taxon"="2001","5000-taxon"="5001")
levels(d$V3)<-list("Low: α=5"="5","Medium: α=1.5"="1.5","High: α=0.15"="0.15")
cairo_pdf(file = 'quartetScore.pdf',height=3.3,width=10.5)
q<-ggplot(data=d[d$V2%in% c("1") ,],aes(x=V6,color=V3))+
  geom_density()+
  theme_bw()+
  theme(legend.position = "right",  axis.text.y = element_text(face="bold"),
        axis.text.x = element_text(face="bold"))+
  scale_color_brewer(name="Divergence from clock (α)",palette="Dark2")+ylab('Density')+
  xlab('Quartet score (True species tree)')+facet_wrap(~V1)
print(q)
dev.off()








cairo_pdf(file = 'quartetScoreBoxPlotAlphaFixed1.5.pdf',height=3.4,width=6.5)
q<-ggplot(data=d[d$V3%in% c("Medium: α=1.5") ,],aes(x=V2,y=V6,fill=V2))+
  geom_boxplot()+
  theme_bw()+
  theme(legend.position = "bottom",  axis.text.y = element_text(face="bold"),
        axis.text.x = element_text(face="bold"))+
  scale_fill_brewer(name="Root to crown ratio",palette="BuPu")+ylab('Quartet score (True species tree)')+
  xlab('Root to crown ratio')+facet_wrap(~V1)
print(q)
dev.off()


cairo_pdf(file = 'quartetScoreBoxPlotOutInFixed1.pdf',height=4,width=9)
q<-ggplot(data=d[d$V2%in% c("1") ,],aes(x=V3,y=V6,fill=V3))+
  geom_boxplot()+
  theme_bw()+
  theme(legend.position = "bottom",  axis.text.y = element_text(face="bold"),
        axis.text.x = element_text(face="bold"))+
  scale_fill_brewer(name="Divergence from clock (α)",palette="BuPu")+ylab('Quartet score (True species tree)')+
  xlab('Divergence from clock (α)')+facet_wrap(~V1)
print(q)
dev.off()

cairo_pdf(file = 'quartetScoreBoxPlot1.pdf',height=2.7,width=1.7)
q<-ggplot(data=d,aes(x=V1,y=V6))+
  geom_boxplot()+ 
  theme_bw()+
  theme(legend.position = "bottom",  axis.text.y = element_text(face="bold"),
        axis.text.x = element_text(face="bold"))+scale_x_discrete(labels=c("30","2000","5000"))+
  scale_fill_brewer(name="Dataset",palette="BuPu")+ylab('Quartet score (True st)')+
  xlab('Dataset')
print(q)
dev.off()



d<-read.csv('../../data/branchlengthAll_root_to_leaf.txt',sep=' ',header=F)
d$V1<-as.factor(d$V1)
d$V2<-as.factor(d$V2)
d$V3<-as.factor(d$V3)
d$V4<-as.factor(d$V4)
levels(d$V1)<-list("30-taxon"="30","2000-taxon"="2000","5000-taxon"="5000")
levels(d$V3)<-list("Low: α=5"="5","Medium: α=1.5"="1.5","High: α=0.15"="0.15")
d$C<-d$V7/d$V6

cairo_pdf(file = 'coefficientVar.pdf',width=10.5,height=3.3)
q<-ggplot(data=d[d$V2 %in% c("1"),],aes(x=C,color=V3))+
  geom_density()+
  facet_wrap(~V1,scales='free_y')+theme_bw()+
  scale_color_brewer(name="Divergence from clock (α)",palette="Dark2")+
  ylab('Density')+xlab('Coefficient of variation of gt root to leaf bl')
print(q)
dev.off()

cairo_pdf(file = 'coefficientVarlog.pdf',width=10.5,height=3.3)
q<-ggplot(data=d[d$V2 %in% c("1"),],aes(x=C,color=V3))+
  geom_density()+theme_bw()+
  facet_wrap(~V1,scales='free_y')+scale_x_log10()+
  scale_color_brewer(name="Divergence from clock (α)",palette="Dark2")+
  ylab('Density')+xlab('Coefficient of variation of gt root to leaf bl')
print(q)
dev.off()



source("../R/setup.r");
d.sum = summarySE(d,measurevar="C",groupvars=c("V1","V2","V3","V4","V5"),na.rm=T,conf.interval=.95)
d.sum$rf = as.numeric(as.character(d.sum$C))
d.sum$rep=as.factor(d.sum$V5)
d.sum$V2<-as.factor(d.sum$V2)

ggplot(data=d.sum[d.sum$V2%in%c("1"),],aes(reorder(rf,rep),rf))+
  ylab("Coefficient of variation of gt root to leaf bl")+
  xlab("Replicates ordered by gene tree error")+theme_bw()+
  geom_errorbar(aes(ymin=rf-sd, ymax=rf+sd),color="blue")+geom_point(size=0.1)+
  theme_bw()+th4+theme(plot.margin=unit(c(0,0,0,0),"mm"))+facet_grid(V3~V1,scales='free')
ggsave('CoefficientBargraph.pdf',width=8,height=6)





