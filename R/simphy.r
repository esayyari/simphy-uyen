d = read.csv(file='../pp_supports.csv',header=F,sep=" ")
d1 = read.csv(file='../bp_support.txt',header=F,sep =" ")
w<-d[,-c(5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20),drop=FALSE]
w1<-d1[,-c(5,6),drop=FALSE]
w1[,4]<-w1[,4]/100
w2<-rbind(cbind(w,method="pp"),cbind(w1,method="bp"))
t <- function(x,ww) {nrow(ww[ ww$V3==1 & ww$V4>=x,]);}

f <- function(x,ww) {nrow(ww[ ww$V3==0 & ww$V4>=x,]);}

tb<- function(x,ww) {nrow(ww[ ww$V3==1 & ww$V4<x,]);}
fb<- function(x,ww) {nrow(ww[ ww$V3==0 & ww$V4<x,]);}
x<-c(-0.1,0,0.000001,0.00001,0.01,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,0.91,0.92,0.93,0.94,0.95,0.96,0.97,0.98,0.99,0.995,0.999,0.9999,0.99999,1)

Pnum<-function(x,ww) {nrow(ww[ww$V4>=x,]);}

rc<- function(ww) {nrow(ww[ ww$V3 ==1, ]);}
gene=c(200,2000)
meth=c("pp","bp")
LT <-data.frame()
for (m in meth){
  for (g in gene){
      gC = w2$V2 %in% g;
      print(g)
      print(m)
      mC = w2$method %in% m;
      a = w2[ gC & mC ,]
      tv<-sapply(x[-1],function(x) (t(x,ww=a)))
      fv<-sapply(x[-1],function(x) (f(x,ww=a)))
      v<-tv/(tv+fv)
      v<-ifelse(is.na(v),tv,v)
      rtv<-sapply(x[-1],function(x) (tb(x,ww=a)))
      rfv<-sapply(x[-1],function(x) (fb(x,ww=a)))
      rcv<-rc(ww=a)
      print(rcv)
      r<-rtv/(rtv+rfv)
      r<-ifelse(is.na(r),rtv,r)
      recall<-tv/rcv
      recall<-ifelse(is.na(recall),tv,recall)
          
      fpRate<-fv/(fv+rfv)
      fpRate<-ifelse(is.na(fpRate),fv,fpRate)
          
      tpRate<-fv/(fv+tv)
      tpRate<-ifelse(is.na(tpRate),fv,tpRate)
        
      L<-cbind(x[-1],v,r,recall,fpRate,tpRate,g,m,"pr")
      LT<-rbind(LT,L)
  }
}
LT$v=as.numeric(levels(LT$v))[LT$v]
LT$V1=as.numeric(levels(LT$V1))[LT$V1]
LT$r=as.numeric(levels(LT$r))[LT$r]
LT$recall=as.numeric(levels(LT$recall))[LT$recall]
LT$fpRate=as.numeric(levels(LT$fpRate))[LT$fpRate]
LT$tpRate=as.numeric(levels(LT$tpRate))[LT$tpRate]


levels(LT$g)<-as.factor(unique(LT$g))

levels(LT$m)<-as.factor(unique(LT$m))

LT$v<-as.numeric(LT$v)
LT$r<-as.numeric(LT$r)
LT$recall<-as.numeric(LT$recall)
LT$V1<-as.numeric(LT$V1)
LT$fpRate<-as.numeric(LT$fpRate)
LT$tpRate<-as.numeric(LT$tpRate)
LT$V12<-1-LT$v


qplot(x=fpRate,y=recall,data=LT,linetype=m,color=g,geom=c("line"))+
  theme_bw()+theme(legend.position="bottom")+xlab("False Positive Rate")+
  ylab("Recall above threshold")+
  scale_linetype_manual(name="method",values=c("dotted","solid"),labels=c("Local PP","MLBS"))+
  scale_color_brewer(name="# genes",palette="Dark2")
ggsave('../figures/ROC.pdf')

qplot(x=V12,y=recall,data=LT,linetype=m,color=g,geom=c("line"))+
theme_bw()+theme(legend.position="bottom")+xlab("FDR")+
  ylab("Recall above threshold")+  
  scale_linetype_manual(name="method",values=c("dotted","solid"),labels=c("Local PP","MLBS"))+
  scale_color_brewer(name="# genes",palette="Dark2")
ggsave('../figures/Recal_vs_FDR.pdf')

qplot(x=V1,y=v,data=LT,linetype=m,color=factor(g),geom=c("line"))+
  scale_y_continuous(labels=percent)+scale_x_continuous(breaks=c(.9,.95,1))+
  theme_bw()+theme(legend.position="bottom")+xlab("reliability")+
  ylab("Precision above threshold")+coord_cartesian(xlim=c(0.894,1.005),ylim=c(0.945,1.002))+
  scale_linetype_manual(name="method",values=c("dotted","solid"),labels=c("Local PP","MLBS"))+
  scale_color_brewer(name="# genes",palette="Dark2")
ggsave('../figures/Percision_vs_reliability.pdf')

qplot(x=V1,y=fpRate,data=LT,linetype=m,color=factor(g),geom=c("line"))+
  scale_y_continuous(labels=percent)+scale_x_continuous(breaks=c(.9,.95,1))+
  theme_bw()+theme(legend.position="bottom")+xlab("Reliability")+
  ylab("False Positive Rate above threshold")+coord_cartesian(xlim=c(0.894,1.005),ylim=c(1-0.984,1-1.002))+
  scale_linetype_manual(name="method",values=c("dotted","solid"),labels=c("Local PP","MLBS"))+
  scale_color_brewer(name="# genes",palette="Dark2")
ggsave('../figures/FP_vs_reliability.pdf')




