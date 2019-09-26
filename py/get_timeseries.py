import glob
import os
import numpy as np
basedir='/projects/niblab/data/HCP_PTN1200/node_timeseries/3T_HCP1200_MSMAll_d15_ts2/puberty'

list_o_nodes=[1,2,5,11]
for num in list_o_nodes:
	node=num+1
	print('starting %i'%node)
	means=open('mean_node_%i.txt'%num,'w')
	for x in glob.glob(os.path.join(basedir,'*.txt')):
		name=x.split('.')[0]
		name=name.split('/')[8]
		print(name)
		with open(x,'r') as infile:
			average=[]
			for y in infile.readlines(): 
				value=y.split()[num]
				average.append(float(value))
			average=np.array(average)
			mean=np.mean(average)
			means.write('%s\t%f\n'%(name,mean))
means.close()	
