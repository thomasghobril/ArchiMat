#!/bin/bash


make clean; make

set -o errexit # stop en cas d'erreur

make clean; make # regénérer les executables

NB_ITER=10

for I in {32..4096..8} 
do
echo $I
exe/test.exe $I $I $NB_ITER
done
