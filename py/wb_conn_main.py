import os
import subprocess
import pandas as pd
import numpy as np
import shutil
import pdb
import multiprocess as mltp
from multiprocess import Pool
import wb_conn as wc
import glob

datapath = '/Users/gracer/Downloads/HCP_S1200_PTNmaps_d15_25_50_100/3T_HCP1200_MSMAll_d15_ts2_Z'
df = pd.read_csv('~/Google Drive/HCP_graph/1200/datasets/solo_subjects510.csv', sep=',')
a = df['subject'].unique()
# b=a.tolist()
b=glob.glob(os.path.join(datapath,'puberty','*.ptseries.nii'))

B, C = wc.split_list(b)


if __name__ == '__main__':
    pool_size = 2
    pool = Pool(processes=pool_size,
                initializer=wc.start_process)
    [beta, gamma]=pool.map(wc.To_pconn,[B,C])
    pool.close()
    pool.join()
