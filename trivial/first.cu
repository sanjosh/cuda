
#include <cuda.h>
#include <stdio.h>

__host__ __device__ void sq(int *a, int numElements)
{
#ifdef __CUDA_ARCH__
	int idx = blockIdx.x * blockDim.x + threadIdx.x;
	a[idx] = a[idx] * a[idx];
#else
	printf("host side\n");
#endif	
}

__global__ void callme(int *a, int numElements)
{
	sq(a, numElements);	
}

int main()
{
	int *a;
	int numElements = 1024;
	cudaMalloc((void**)a, numElements);
	int blockSize = 16;
	int numBlocks = numElements/blockSize;
	callme <<<numBlocks, blockSize>>> (a, numElements);
	if (cudaDeviceSynchronize() != cudaSuccess) {
		printf("error\n");
	}
	cudaFree(a);
}
