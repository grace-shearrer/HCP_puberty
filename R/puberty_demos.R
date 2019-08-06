library(dplyr)
library(plyr)
library(psych)
library(ggplot2)
library(lmtest)
library(lm.beta)
data<-read.table("~/Google Drive/HCP_graph//1200/RESTRICTED_gshearrer_4_19_2018_11_33_34.csv",sep=",",header=T)
data0<-read.table("~/Google Drive/HCP_graph//1200/unrestricted_gshearrer_4_19_2018_11_31_37.csv",sep=",",header=T)
names(data0)
dim(data0)
names(data)
dim(data)
myvars<-c("Subject","Age_in_Yrs","Race","Ethnicity","BMI","Menstrual_RegCycles","Menstrual_AgeBegan","Menstrual_BirthControlCode","Hyperthyroidism", "OtherEndocrn_Prob")
myvars0<-c("Subject","Gender")

data1<-data[myvars]
data2<-data0[myvars0]

df<-join(data1,data2)
head(df)
#how many females = 656
female<-subset(df, df$Gender == "F")
dim(female)
head(female)

female_noout<-subset(female, female$Menstrual_AgeBegan < 24)
ggplot(female_noout, aes(Menstrual_AgeBegan, BMI, color=Race)) +
  geom_point(shape=1) + 
  geom_smooth(method=lm)  

ggplot(female_noout, aes(Age_in_Yrs, BMI, color=Race)) +
  geom_point(shape=1) + 
  geom_smooth(method=lm)  
#remove outliers and those with endo problems

female_noendo<-subset(female_noout, female_noout$Hyperthyroidism == 0)
dim(female_noendo)#645
female_noendo<-subset(female_noout, female_noout$OtherEndocrn_Prob == 0)
dim(female_noendo)#628
head(female_noendo)
scans<-read.table("~/Google Drive/MetX/1200/scan_subs.txt", sep=" ", header=T)
dim(scans)
scan_only<-merge(female_noendo, scans, by="Subject")
dim(scan_only)

ggplot(scan_only, aes(Menstrual_AgeBegan, BMI)) +
  geom_point(shape=1) + 
  geom_smooth(method=lm)  


head(female_noendo)
m1<-lm( BMI ~  Menstrual_AgeBegan, data=scan_only)
summary(m1)
m2<-lm( BMI ~  Menstrual_AgeBegan+Age_in_Yrs, data=scan_only)
lrtest(m1,m2)
summary(m2)
m3<-lm( BMI ~  Menstrual_AgeBegan+Age_in_Yrs+Race, data=scan_only)
lrtest(m2,m3)
summary(m3)
lm.beta(m3)
r=sqrt(0.02482)
r

ggplot(female_noendo, aes(Menstrual_AgeBegan, BMI)) +
  geom_point(shape=1, size = 5, colour= "light blue") + 
  geom_smooth(method=lm,colour='orange', size = 3)+theme_classic()+scale_y_continuous(name="Body Mass Index (BMI)")+
  scale_x_continuous(name="Age at onset of menses")+
  theme(axis.title.x = element_text( size=30, face="bold"),axis.text.x  = element_text(size=30))+
  theme(axis.title.y = element_text( size=30, face="bold"),axis.text.y  = element_text(size=30))

describe(scan_only)
mean(scan_only$Age_in_Yrs)-mean(scan_only$Menstrual_AgeBegan)
scan_only$Race<-as.factor(scan_only$Race)
summary(scan_only$Race)
scan_only$Ethnicity<-as.factor(scan_only$Ethnicity)
summary(scan_only$Ethnicity)


