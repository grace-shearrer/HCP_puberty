#a simple script to find the timeseries needed and move it into the correct folder
import os
import glob
import sys
import fnmatch
import shutil

basedir='/projects/niblab/scripts/HCP_puberty'
datadir='/projects/niblab/data/HCP_PTN1200/node_timeseries/3T_HCP1200_MSMAll_d15_ts2'
pubertydir=os.path.join(datadir,'puberty')

g=os.path.join(basedir,'subs.txt')

if os.path.exists(pubertydir):
	print('already have a puberty folder')
else:
	os.mkdir(pubertydir)

for file in glob.glob(os.path.join(datadir,'*.txt')):
	sub0=file.split('/')[7]
	sub=sub0.strip('.txt')
	with open(g,'r') as low_search:
		print "searching"
		for line in low_search:
			line=line.split('\t')[0]
			line=line.strip('\n')
			print 'comparing '+line+' '+sub
			if fnmatch.fnmatch(sub,line):
				print "coping "+sub+" to puberty folder"
				shutil.copy(file,os.path.join(datadir,'puberty'))
