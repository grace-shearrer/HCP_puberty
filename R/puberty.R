library(dplyr)
library(plyr)
library(psych)
library(ggplot2)
library(lmtest)
library(lm.beta)
data<-read.table("~/Google Drive/HCP_graph/1200/RESTRICTED_gshearrer_4_19_2018_11_33_34.csv",sep=",",header=T)
data0<-read.table("~/Google Drive/HCP_graph/1200/unrestricted_gshearrer_4_19_2018_11_31_37.csv",sep=",",header=T)
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
female$Menstrual_RegCycles
#regular cycles = 513
female_reg<-subset(female, female$Menstrual_RegCycles == 1)
head(female_reg)
dim(female_reg)
ggplot(female, aes(Menstrual_AgeBegan)) + geom_histogram(binwidth=.5)

mytable <- table(female_reg$Race,female_reg$Ethnicity) # A will be rows, B will be columns 
margin.table(mytable, 2) #only 33 people reported being hispanic
prop.table(mytable) 

describe.by(female_reg, female_reg$Menstrual_AgeBegan)

describe(female_reg$Menstrual_AgeBegan)
describe(female$Menstrual_AgeBegan)

ggplot(female, aes(Menstrual_AgeBegan, BMI, color=Race)) +
  geom_point(shape=1) + 
  geom_smooth(method=lm)  

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

ggplot(female_noendo, aes(Menstrual_AgeBegan, BMI)) +
  geom_point(shape=1) + 
  geom_smooth(method=lm)  

#making design 
dim(female_noendo)
female_noendo$BMI_c<-scale(female_noendo$BMI, scale=FALSE)
female_noendo$Menstrual_AgeBegan_c<-scale(female_noendo$Menstrual_AgeBegan, scale=FALSE)
female_noendo$BMIxMenses_c<-female_noendo$BMI_c*female_noendo$Menstrual_AgeBegan_c
head(female_noendo)
female_noendo$Race

female_noendo$race[female_noendo$Race=="White"]<-1
female_noendo$race[female_noendo$Race=="Black or African Am."]<-2
female_noendo$race[female_noendo$Race=="Asian/Nat. Hawaiian/Othr Pacific Is."]<-2
female_noendo$race[female_noendo$Race=="Am. Indian/Alaskan Nat."]<-3
female_noendo$race[female_noendo$Race=="Unknown or Not Reported"]<-4
female_noendo$race[female_noendo$Race=="More than one"]<-5
female_noendo$race[female_noendo$Race=="White" & female_noendo$Ethnicity=="Hispanic/Latino"]<-6
female_noendo$race[female_noendo$Race=="Black or African Am."  & female_noendo$Ethnicity=="Hispanic/Latino"]<-7
female_noendo$race[female_noendo$Race=="Asian/Nat. Hawaiian/Othr Pacific Is."  & female_noendo$Ethnicity=="Hispanic/Latino"]<-8
female_noendo$race[female_noendo$Race=="Am. Indian/Alaskan Nat."  & female_noendo$Ethnicity=="Hispanic/Latino"]<-9
female_noendo$race[female_noendo$Race=="Unknown or Not Reported"  & female_noendo$Ethnicity=="Hispanic/Latino"]<-10
female_noendo$race[female_noendo$Race=="More than one"  & female_noendo$Ethnicity=="Hispanic/Latino"]<-11
female_noendo$ones<-female_noendo$race/female_noendo$race

final_vars<-c("Subject","ones","BMI_c","Menstrual_AgeBegan_c","BMIxMenses_c","race","Age_in_Yrs")
final<-female_noendo[final_vars]
head(final)
head(female_noendo)
m1<-lm( BMI ~  Menstrual_AgeBegan, data=female_noendo)
summary(m1)
m2<-lm( BMI ~  Menstrual_AgeBegan+Age_in_Yrs, data=female_noendo)
lrtest(m1,m2)
summary(m2)
m3<-lm( BMI ~  Menstrual_AgeBegan+Age_in_Yrs+race, data=female_noendo)
lrtest(m3)
summary(m3)
lm.beta(m3)
r=sqrt(0.05343)
r
ggplot(female_noendo, aes(Menstrual_AgeBegan, BMI)) +
  geom_point(shape=1) + 
  geom_smooth(method=lm,colour='black')+theme_classic()+scale_y_continuous(name="Body Mass Index (BMI)")+
  scale_x_continuous(name="Age of onset of menstration")+
  theme(axis.title.x = element_text( size=20),axis.text.x  = element_text(size=20))+
  theme(axis.title.y = element_text( size=20),axis.text.y  = element_text(size=20))

describe(female_noendo)
mean(female_noendo$Age_in_Yrs)-mean(female_noendo$Menstrual_AgeBegan)
female_noendo$Race<-as.factor(female_noendo$Race)
summary(female_noendo$Race)
female_noendo$Ethnicity<-as.factor(female_noendo$Ethnicity)
summary(female_noendo$Ethnicity)
# write.table(final, "~/Google Drive/MetX/1200/glm.txt", row.names = F, col.names = F, sep="\t")
# write.table(final$ones,"~/Google Drive/MetX/1200/design.grp", row.names = F, col.names = F, sep="\t")
# write.table(female_noendo$Subject,"~/Google Drive/MetX/1200/subs.txt", row.names = F, col.names = F, sep="\t")
##################

