#!/bin/bash
nvcc -Xcompiler -fopenmp -O3 -o saxpy.exe saxpy.cu
