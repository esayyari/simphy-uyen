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
levels(d$V1)<-list("31-taxon"="31","2001-taxon"="2001","5001-taxon"="5001")
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
levels(d$V1)<-list("31-taxon"="31","2001-taxon"="2001","5001-taxon"="5001")
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
levels(d$V1)<-list("31-taxon"="31","2001-taxon"="2001","5001-taxon"="5001")
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


