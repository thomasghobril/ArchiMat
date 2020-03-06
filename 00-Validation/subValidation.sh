#PBS -S /bin/bash
#PBS -N ValidationJob
#PBS -e errorJob.txt
#PBS -j oe
#PBS -l walltime=0:10:00
#PBS -l select=1:ncpus=20:cpugen=skylake
#PBS -l place=excl
#PBS -m abe -M laurent.cabaret@centralesupelec.fr
#PBS -P progpar


# Load the same modules as for compilation
module load gcc/9.2.0

# Go to the current directory
cd $PBS_O_WORKDIR

# Run code
#export KMP_AFFINITY=verbose
sh test.sh
