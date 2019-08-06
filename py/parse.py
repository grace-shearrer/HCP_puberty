import numpy as np
import glob 
import os
import csv

list_names=['BMI_pos','BMI_neg','AoM_pos','AoM_neg','int_pos','int_neg']
with open('tstat.txt','r') as infile:
	for line in infile.readlines():
		data=line.split()
		chunks = [data[x:x+15] for x in xrange(0, len(data), 15)]
		print(chunks)
with open("output.csv", "wb") as f:
    writer = csv.writer(f)
    writer.writerows(chunks)
f.close()
