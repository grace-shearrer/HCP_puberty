# post hoc analysis of HCP data for puberty paper
library(plyr)
library(psych)
library(ggplot2)
library(Hmisc)
#load in all datasets
unres<-read.table("~/Google Drive/HCP_graph/1200/datasets/unrestricted_gshearrer_7_24_2019_11_58_3.csv", header=T, sep=",")
res<-read.table("~/Google Drive/HCP_graph/1200/datasets/RESTRICTED_gshearrer_4_19_2018_11_33_34.csv", header=T, sep=",")
interest<-read.table("~/Google Drive/HCP_graph/1200/5000perms/post_hoc/vars_of_interest.csv", sep=",", header=F)
glm<-read.table("~/Google Drive/HCP_graph/1200/5000perms/glm.txt", sep="\t", header=F)
names(unres)
head(glm)
names(glm)<-c("Subject", "group","BMI_C","AOM_C","int","race","age")
subs<-read.table("~/Google Drive/HCP_graph/1200/datasets/subjectIDs.txt", header=F, sep=" ")
names(subs)<-"Subject"
netmat<-read.table("~/Google Drive/HCP_graph/1200/datasets/3T_HCP1200_MSMAll_d15_ts2/netmats1.txt", header=F, sep=" ")
NM<-cbind(subs,netmat)

d0<-join(unres, res)
d1<-join(d0,glm)
#View(d1)

d2<-d1[,colnames(d1)%in%interest$V1] 
names(d2)

d3<-join(d2,NM)

d4<-subset(d3, d3$group == 1)

x<-(1:225)
B = matrix( x,nrow=15, ncol=15)

## nodes of interest ##
# sig 3->6 == V36
# check 6 -> 3 == V78
# 12->13 == V192
# 13->12 == V178

# control variables
# Race
# Ethnicity
# Age_in_Yrs
hist(d4$DDisc_AUC_200)
describe(d4$DDisc_AUC_200)


# Delay Discounting: Area Under the Curve for Discounting of $200 (DDisc_AUC_200)	Cognition	Self-regulation/Impulsivity (Delay Discounting)	DDisc_AUC_200
mDD1<-lm(V36~DDisc_AUC_200+BMI*Menstrual_AgeBegan+Age_in_Yrs+Race+Ethnicity, data = d4)
summary(mDD1)

mDD2<-lm(V78~DDisc_AUC_200+BMI*Menstrual_AgeBegan+Age_in_Yrs+Race+Ethnicity, data = d4)
summary(mDD2)

# Delay Discounting: Area Under the Curve for Discounting of $40,000 (DDisc_AUC_40K)	Cognition	Self-regulation/Impulsivity (Delay Discounting)	DDisc_AUC_40K
mDD3<-lm(V36~DDisc_AUC_40K+BMI*Menstrual_AgeBegan+Age_in_Yrs+Race+Ethnicity, data = d4)
summary(mDD3)

mDD4<-lm(V78~DDisc_AUC_40K+BMI*Menstrual_AgeBegan+Age_in_Yrs+Race+Ethnicity, data = d4)
summary(mDD4)


# NIH Toolbox Picture Sequence Memory Test: Age-Adjusted Scale Score
# NIH Toolbox Dimensional Change Card Sort Test: Age-Adjusted Scale Score
# NIH Toolbox Flanker Inhibitory Control and Attention Test: Age-Adjusted Scale Score
# NIH Toolbox Cognition Fluid Composite: Age Adjusted Scale Score
# NIH Toolbox Cognition Total Composite Score: Age Adjusted Scale Score
# NIH Toolbox Cognition Crystallized Composite: Age Adjusted Scale Score

# NIH Toolbox 2-minute Walk Endurance Test : Age-Adjusted Scale Score	Motor	Endurance (2 minute walk test)	Endurance_AgeAdj
# NIH Toolbox 4-Meter Walk Gait Speed Test: Computed Score	Motor	Locomotion (4-meter walk test)	GaitSpeed_Comp
# NIH Toolbox 9-hole Pegboard Dexterity Test : Age-Adjusted Scale Score	Motor	Dexterity (9-hole Pegboard)	Dexterity_AgeAdj
# NIH Toolbox Grip Strength Test: Age-Adjusted-Adjusted Scale Score	Motor	Strength (Grip Strength Dynamometry)	Strength_AgeAdj

# NEO-FFI Agreeableness (NEOFAC_A)	Personality	Five Factor Model (NEO-FFI) Factor Summary Scores	NEOFAC_A
# NEO-FFI Openness to Experience (NEOFAC_O)	Personality	Five Factor Model (NEO-FFI) Factor Summary Scores	NEOFAC_O
# NEO-FFI Conscientiousness (NEOFAC_C)	Personality	Five Factor Model (NEO-FFI) Factor Summary Scores	NEOFAC_C
# NEO-FFI Neuroticism (NEOFAC_N)	Personality	Five Factor Model (NEO-FFI) Factor Summary Scores	NEOFAC_N
# NEO-FFI Extraversion (NEOFAC_E)	Personality	Five Factor Model (NEO-FFI) Factor Summary Scores	NEOFAC_E


# NIH Toolbox Anger-Affect Survey: Unadjusted Scale Score	Emotion	Negative Affect (Sadness, Fear, Anger)	AngAffect_Unadj
# NIH Toolbox Anger-Hostility Survey: Unadjusted Scale Score	Emotion	Negative Affect (Sadness, Fear, Anger)	AngHostil_Unadj
# NIH Toolbox Anger-Physical Aggression Survey: Unadjusted Scale Score	Emotion	Negative Affect (Sadness, Fear, Anger)	AngAggr_Unadj
# NIH Toolbox Fear-Affect Survey: Unadjusted Scale Score	Emotion	Negative Affect (Sadness, Fear, Anger)	FearAffect_Unadj
# NIH Toolbox Fear-Somatic Arousal Survey: Unadjusted Scale Score	Emotion	Negative Affect (Sadness, Fear, Anger)	FearSomat_Unadj
# NIH Toolbox Sadness Survey: Unadjusted Scale Score	Emotion	Negative Affect (Sadness, Fear, Anger)	Sadness_Unadj
# NIH Toolbox General Life Satisfaction Survey: Unadjusted Scale Score	Emotion	Psychological Well-being (Positive Affect, Life Satisfaction, Meaning and Purpose)	LifeSatisf_Unadj
# NIH Toolbox Meaning and Purpose Survey: Unadjusted Scale Score	Emotion	Psychological Well-being (Positive Affect, Life Satisfaction, Meaning and Purpose)	MeanPurp_Unadj
# NIH Toolbox Positive Affect Survey: Unadjusted Scale Score	Emotion	Psychological Well-being (Positive Affect, Life Satisfaction, Meaning and Purpose)	PosAffect_Unadj
# NIH Toolbox Friendship Survey: Unadjusted Scale Score	Emotion	Social Relationships (Social Support, Companionship, Social Distress, Positive Social Development)	Friendship_Unadj
# NIH Toolbox Loneliness Survey: Unadjusted Scale Score	Emotion	Social Relationships (Social Support, Companionship, Social Distress, Positive Social Development)	Loneliness_Unadj
# NIH Toolbox Perceived Hostility Survey: Unadjusted Scale Score	Emotion	Social Relationships (Social Support, Companionship, Social Distress, Positive Social Development)	PercHostil_Unadj
# NIH Toolbox Perceived Rejection Survey: Unadjusted Scale Score	Emotion	Social Relationships (Social Support, Companionship, Social Distress, Positive Social Development)	PercReject_Unadj
# NIH Toolbox Emotional Support Survey: Unadjusted Scale Score	Emotion	Social Relationships (Social Support, Companionship, Social Distress, Positive Social Development)	EmotSupp_Unadj
# NIH Toolbox Instrumental Support Survey: Unadjusted Scale Score	Emotion	Social Relationships (Social Support, Companionship, Social Distress, Positive Social Development)	InstruSupp_Unadj
# NIH Toolbox Perceived Stress Survey: Unadjusted Scale Score	Emotion	Stress and Self Efficacy (Perceived Stress, Self-Efficacy)	PercStress_Unadj
# NIH Toolbox Self-Efficacy Survey: Unadjusted Scale Score	Emotion	Stress and Self Efficacy (Perceived Stress, Self-Efficacy)	SelfEff_Unadj


# PLOTS
ggplot(d4, aes(Menstrual_AgeBegan, BMI)) +
  geom_point(shape=1) + 
  geom_smooth(method=lm,colour='black')+theme_classic()+scale_y_continuous(name="Body Mass Index (BMI)")+
  scale_x_continuous(name="Age of onset of menstration")+
  theme(axis.title.x = element_text( size=20),axis.text.x  = element_text(size=20))+
  theme(axis.title.y = element_text( size=20),axis.text.y  = element_text(size=20))

