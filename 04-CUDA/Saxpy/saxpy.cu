#include <stdio.h>
#include <iostream>
#include "cuda_runtime.h"
#include "cuda.h"
#include "omp.h"
#include "device_launch_parameters.h"
#include <chrono>

using namespace std;

__global__ void gpu_saxpy(int n, float a, float *x, float *y, float *s)
{
  int i = blockIdx.x*blockDim.x + threadIdx.x;
  if (i < n) s[i] = a*x[i] + y[i];
}

void cpu_saxpy(int n, float a, float *x, float *y, float *s)
{
  #pragma omp parallel for num_threads(12) 
  for (int i=0; i<n; i++)
  {
      s[i] = a*x[i] + y[i];
  }
}

void cpu_saxpy_mono(int n, float a, float *x, float *y, float *s)
{
  for (int i=0; i<n; i++)
  {
      s[i] = a*x[i] + y[i];
  }
}


int main(void)
{
  unsigned long int N = 4096*4096*16;
  float *x, *y, *s_cpu, *s_gpu, *d_x, *d_y, *d_s;
  
  x = (float*)malloc(N*sizeof(float));
  y = (float*)malloc(N*sizeof(float));
  s_gpu = (float*)malloc(N*sizeof(float));
  s_cpu = (float*)malloc(N*sizeof(float));

  cudaMalloc(&d_x, N*sizeof(float)); 
  cudaMalloc(&d_y, N*sizeof(float));
  cudaMalloc(&d_s, N*sizeof(float));

  for (int i = 0; i < N; i++) {
    x[i] = 1.0f;
    y[i] = 2.0f;
  }

  std::chrono::high_resolution_clock::time_point t0 = std::chrono::high_resolution_clock::now();
  cpu_saxpy(N, 2.0f, x, y, s_cpu);
  std::chrono::high_resolution_clock::time_point t1 = std::chrono::high_resolution_clock::now();
  auto cpu_duration = std::chrono::duration<double>(t1-t0).count();

  cudaMemcpy(d_x, x, N*sizeof(float), cudaMemcpyHostToDevice);
  cudaMemcpy(d_y, y, N*sizeof(float), cudaMemcpyHostToDevice);

  int k = 32; 
  t0 = std::chrono::high_resolution_clock::now();
  gpu_saxpy<<<(N+k)/k, k>>>(N, 2.0f, d_x, d_y, d_s);  
  t1 = std::chrono::high_resolution_clock::now();
  auto gpu_duration = std::chrono::duration<double>(t1-t0).count();
  cudaMemcpy(s_gpu, d_s, N*sizeof(float), cudaMemcpyDeviceToHost);

    float maxError = 0.0f;
  for (int i = 0; i < N; i++)
    maxError = std::max(maxError, s_cpu[i]-s_gpu[i]);
  printf("Max error: %f\n", maxError);

  printf("cpu_duration: %f\n", cpu_duration);
  printf("gpu_duration: %f\n", gpu_duration);


  k = 512; 
  t0 = std::chrono::high_resolution_clock::now();
  gpu_saxpy<<<(N+k)/k, k>>>(N, 2.0f, d_x, d_y, d_s);  
  t1 = std::chrono::high_resolution_clock::now();
  gpu_duration = std::chrono::duration<double>(t1-t0).count();
  cudaMemcpy(s_gpu, d_s, N*sizeof(float), cudaMemcpyDeviceToHost);

  maxError = 0.0f;
  for (int i = 0; i < N; i++)
    maxError = std::max(maxError, s_cpu[i]-s_gpu[i]);
  printf("Max error: %f\n", maxError);

  printf("cpu_duration: %f\n", cpu_duration);
  printf("gpu_duration: %f\n", gpu_duration);


  k = 2048; 
  t0 = std::chrono::high_resolution_clock::now();
  gpu_saxpy<<<(N+k)/k, k>>>(N, 2.0f, d_x, d_y, d_s);  
  t1 = std::chrono::high_resolution_clock::now();
  gpu_duration = std::chrono::duration<double>(t1-t0).count();
  cudaMemcpy(s_gpu, d_s, N*sizeof(float), cudaMemcpyDeviceToHost);
  
  maxError = 0.0f;
  for (int i = 0; i < N; i++)
    maxError = std::max(maxError, s_cpu[i]-s_gpu[i]);
  printf("Max error: %f\n", maxError);

  printf("cpu_duration: %f\n", cpu_duration);
  printf("gpu_duration: %f\n", gpu_duration);
  
  cudaFree(d_x);
  cudaFree(d_y);
  cudaFree(d_s);
  free(x);
  free(y);
  free(s_cpu);
  free(s_gpu);
}

