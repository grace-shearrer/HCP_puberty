import os
import subprocess
import pandas as pd
import numpy as np
import shutil
import pdb
import multiprocess as mltp
from multiprocess import Pool

def start_process():
    print('Starting', mltp.current_process().name)

def split_list(a_list):
    half = len(a_list)//2
    return a_list[:half], a_list[half:]

def selecter(b, datapath):
    for sub in b:
        # print(row)
        print(os.path.join(datapath,'%s.dtseries.nii'%sub))
        infile=os.path.join(datapath,'%s.dtseries.nii'%sub)
        outfile=os.path.join(datapath,'puberty','%s.dtseries.nii'%sub)
        if os.path.exists(outfile) == True:
            print('got it')
        else:
            shutil.move(infile,outfile)
            # import pdb; pdb.set_trace()
def To_pseries(b, datapath):
    for sub in b:
        infile=os.path.join(datapath,'puberty','%s.dtseries.nii'%sub)
        outfile=outfile=os.path.join(datapath,'puberty','%s.ptseries.nii'%sub)
        atlas='/Users/gracer/Google Drive/HCP_graph/1200/datasets/Gordon_Q1-Q6_RelatedValidation210_comb.dlabel.nii'
        if os.path.exists(atlas):
            print(sub)
            command = ['wb_command' ,'-cifti-parcellate', infile, atlas, 'COLUMN', outfile]
            callout = subprocess.Popen(command)
            callout.communicate()

def To_pconn(b):
        for infile in b:
            sub=infile.split('/')[7].split('.')[0]
            outfile=outfile=os.path.join('/Users/gracer/Downloads/HCP_S1200_PTNmaps_d15_25_50_100/3T_HCP1200_MSMAll_d15_ts2_Z','puberty','%s.pconn.nii'%sub)
            print(sub)
            command = ['wb_command' ,'-cifti-correlation', infile, outfile]
            callout = subprocess.Popen(command)
            callout.communicate()
