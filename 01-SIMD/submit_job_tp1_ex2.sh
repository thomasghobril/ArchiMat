#PBS -S /bin/bash
#PBS -N tp1_ex2
#PBS -e errorJob.txt
#PBS -j oe
#PBS -l walltime=0:01:00
#PBS -l select=1:ncpus=20:cpugen=skylake
#PBS -l place=excl
#PBS -m abe -M laurent.cabaret@centralesupelec.fr
#PBS -P progpar


# Load the same modules as for compilation
module load gcc/7.3.0
# module load intel-compilers/2019.3
# Go to the current directory
cd $PBS_O_WORKDIR

# Run code
#export KMP_AFFINITY=verbose
echo "Avec vectorisation"
exe/tp1_ex2_vec.exe 100 200
exe/tp1_ex2_vec.exe 100 640
exe/tp1_ex2_vec.exe 100 2500

echo "Sans vectorisation"
exe/tp1_ex2_novec.exe 100 200
exe/tp1_ex2_novec.exe 100 640
exe/tp1_ex2_novec.exe 100 2500

/gpfs/opt/bin/fusion-whereami
date
time sleep 2


