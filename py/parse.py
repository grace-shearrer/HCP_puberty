import numpy as np
import glob
import os
import csv
import pandas as pd

basepath = '/Users/gracer/Desktop/'
print(basepath)
# import pdb; pdb.set_trace()
list_names=['BMI_pos','BMI_neg','AoM_pos','AoM_neg','int_pos','int_neg','motion']
filepath=os.path.join(basepath,'hmotion_corr','p_corr.txt')

df=pd.read_csv('filepath', sep='\t',header=None)
df.values

with open(filepath,'r') as infile:
	for line in infile.readlines():
		data=line.split()
		chunks = [data[x:x+15] for x in range(0, len(data), 15)]
		# print(chunks)
		with open(os.path.join(basepath,"p_output.csv"), "wb") as f:
		    # writer = csv.writer(f)
			for x in chunks:
				print(x)
f.close()
