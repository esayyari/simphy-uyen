setwd(dirname(sys.frame(1)$ofile))
d<-read.csv('../final/parameters/parameter.log.info-total',sep=" ",header=T)
db=d; 

d1<-read.csv('../genetree_estimation-error.csv',sep=' ',header=F)
d1$V10=(d1$V9+d1$V6)/2
gte = dcast(d1[,c(1,2,3,10)],V1+V2+V3~.,mean)
names(gte)[4]<-"mean_gt_error"
gte = cbind(gte,dcast(d1[,c(1,2,3,10)],V1+V2+V3~.,sd)[,4])
names(gte)[5]<-"sd_gt_error"
d = merge(d,gte[gte$V3=="jc",c(2,4,5)],by.x = "Replicate",by.y = "V2")

gtl=read.csv('../final/parameters/gtbranchlength.info.mean',sep=" ",header=F)
d <- merge(d,gtl,by.y = "V1", by.x = "Replicate")
names(d)[18]<-"mean_gt_length"
gtla=read.csv('../final/parameters/gtbranchlength.info',sep=" ",header=F)
med <- dcast(gtla,V1~.,median)
names(med)[2] <- "med_gt_length"
d <- merge(d,med,by.y = "V1", by.x = "Replicate")

dp<-read.csv("../polyTomyStat-final.csv",sep = ' ',header=F)
pp = dcast(dp[,c(1,2,5)],V1+V2~.,mean)
names(pp)[3]<-"mean_polytomy"
d = merge(d,pp[pp$V2=="jc",c(1,3)],by.x = "Replicate",by.y = "V1")

require(ggplot2)
qplot(data=d,y=2000-outgroup_miss_replacement,x=mean_gt_error)
qplot(data=d,Global_substitution_rate,mean_gt_error2,log='x')
qplot(data=d,mean_seq_length*Global_substitution_rate*Generations,mean_gt_error,log='x')
qplot(data=d,mean_seq_length*med_gt_length,mean_gt_error,log='x')
qplot(data=d,Generations,mean_gt_error2,log='x')
qplot(data=d,Global_substitution_rate,2000-outgroup_miss_replacement)
qplot(data=d,y=mean_polytomy,x=mean_gt_error)

