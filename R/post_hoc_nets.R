library(plyr)

subs<-read.table("~/Google Drive/HCP_graph/1200/datasets/subjectIDs.txt", header=F, sep=" ")
netmat<-read.table("~/Google Drive/HCP_graph/1200/datasets/3T_HCP1200_MSMAll_d15_ts2/netmats1.txt", header=F, sep=" ")

NM<-cbind(subs,netmat)

x<-(1:225)
x

B = matrix( x,nrow=15, ncol=15)
B

# sig 3->6 == 36
# check 6 -> 3 == 78
# 12->13 == 192
# 13->12 == 178

