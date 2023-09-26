#!/bin/bash

set -o errexit

echo "Avec vectorisation"
for I in {32..4096..16}
do
  (( ITER=10))
  exe/tp1_ex2_vec.exe $ITER $I
done

echo "Sans vectorisation"
for I in {32..4096..16}
do
  (( ITER=10))
  exe/tp1_ex2_novec.exe $ITER $I
done

