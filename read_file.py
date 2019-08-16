import os
import glob
import sys
import fnmatch

basedir='/projects/niblab/scripts/HCP_puberty'
slope_name=os.path.join(basedir,'glm.txt')

g=open('design.txt','w')
h=open('group.txt','w')
i=0 
listy= glob.glob('/projects/niblab/data/HCP_PTN1200/node_timeseries/3T_HCP1200_MSMAll_d15_ts2/puberty/*.txt')
listy.sort()

for dir in listy:
	sub0=dir.split('/')
	sub=sub0[8].strip('.txt')
	with open(slope_name, 'r') as search2:
		for line2 in search2:
			line2 = line2.split('\t')
			name2 = line2[0]
			print name2
			AoM = line2[3]
			BMI = line2[2]
			BMIxAoM = line2[4]
			Age= line2[5]
			Race=line2[6].strip('\n')
			print('this is the subject %s and this is the line name %s'%(sub,name2))
			if fnmatch.fnmatch(name2, sub):
				g.write('1\t%s\t%s\t%s\t%s\t%s\n'%(BMI,AoM,BMIxAoM,Age,Race))
				g.write('1\t%s\t%s\t%s\t%s\t%s\n'%(BMI,AoM,BMIxAoM,Age,Race))
				g.write('1\t%s\t%s\t%s\t%s\t%s\n'%(BMI,AoM,BMIxAoM,Age,Race))
				g.write('1\t%s\t%s\t%s\t%s\t%s\n'%(BMI,AoM,BMIxAoM,Age,Race))
				h.write('1\n1\n1\n1\n')
g.close()
h.close()
