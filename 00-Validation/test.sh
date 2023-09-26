#!/bin/bash

set -o errexit

make clean; make

for I in {32..4096..8}
do
(( ITER=10))
exe/test.exe $I $I $ITER
done


