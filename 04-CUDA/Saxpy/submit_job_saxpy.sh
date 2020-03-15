#!/bin/bash

#PBS -S /bin/bash
#PBS -N td4_saxpy
#PBS -e errorJob.txt
#PBS -j oe
#PBS -l walltime=0:10:00
#PBS -l select=1:ncpus=12:ngpus=1
#PBS -q gpuq
#PBS -m abe -M laurent.cabaret@centralesupelec.fr
#PBS -P progpar

# Go to the current directory
cd $PBS_O_WORKDIR

# Load the same modules as for compilation
module load gcc/7.3.0
module load cuda/10.2 

sh compile.sh

# Run code
echo "Info sur la carte"
nvidia-smi -L


echo "Lancement du bench"
./saxpy.exe

/gpfs/opt/bin/fusion-whereami
date
time sleep 2


