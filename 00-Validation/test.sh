#!/bin/bash
make clean; make

for I in {512..1024..1}
do
(( ITER=3))
exe/test.exe $I $I $ITER
done


