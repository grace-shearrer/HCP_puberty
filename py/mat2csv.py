import scipy.io
import numpy as np
import os

def mat2csv(matfile,save_dir):
    data = scipy.io.loadmat(matfile)
    print(matfile)
    print(save_dir)
    for i in data:
        if '__' not in i and 'readme' not in i:
            np.savetxt((os.path.join(save_dir,'%s'%i,'.csv')),data[i],fmt='%s',delimiter=',')

