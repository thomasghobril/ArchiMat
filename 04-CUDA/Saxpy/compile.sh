#!/bin/bash
nvcc -std=c++11 -Xcompiler -fopenmp -O3 -o saxpy.exe saxpy.cu
