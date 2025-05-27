#include<cuda_runtime.h>
#include<stdio.h>

int main() {
    int deviceCount;
    cudaGetDeviceCount(&deviceCount);

    for (int i = 0; i < deviceCount; i++) {
        cudaDeviceProp prop;
        cudaGetDeviceProperties(&prop, i);

        printf("Device #%d: %s\n", i, prop.name);
        printf("  Compute capability: %d.%d\n", prop.major, prop.minor);
        printf("  Total global memory: %lu bytes\n", prop.totalGlobalMem);
        printf("  Max threads per block: %d\n", prop.maxThreadsPerBlock);
        printf("  Max threads per dimension (x,y,z): %d, %d, %d\n",
               prop.maxThreadsDim[0], prop.maxThreadsDim[1], prop.maxThreadsDim[2]);
        printf("  Max grid size (x,y,z): %d, %d, %d\n",
               prop.maxGridSize[0], prop.maxGridSize[1], prop.maxGridSize[2]);
        printf("  Number of multiprocessors: %d\n", prop.multiProcessorCount);
        printf("  Warp size: %d\n", prop.warpSize);
        printf("\n");
    }

    printf("hello, world!\n");
}