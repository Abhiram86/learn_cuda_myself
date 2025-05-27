#include <cuda_runtime.h>
#include <stdio.h>
#include "../include/Matrix.h"

__global__ void addVectors2D(int *a, int *b, int *c, int n) {
    int col = threadIdx.x + blockDim.x * blockIdx.x;
    int row = threadIdx.y + blockDim.y * blockIdx.y;
    if (row < n && col < n) {
        int idx = row * n + col;
        c[idx] = a[idx] + b[idx];
    }
}

int main(){
    Matrix a(3, 3), b(3, 3), c(3, 3);

    const int matSize = a.cols * a.rows * sizeof(int);

    a.MatGetInput();
    printf("\n");
    b.MatGetInput();

    int *flat_a = a.FlattenCopy();
    int *flat_b = b.FlattenCopy();
    int *flat_c = c.FlattenCopy();

    int *d_a, *d_b, *d_c;

    cudaMalloc((void**)&d_a, matSize);
    cudaMalloc((void**)&d_b, matSize);
    cudaMalloc((void**)&d_c, matSize);

    cudaMemcpy(d_a, flat_a, matSize, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, flat_b, matSize, cudaMemcpyHostToDevice);

    dim3 threadsPerBlock(16, 16);
    dim3 numBlocks((a.cols + threadsPerBlock.x - 1) / threadsPerBlock.x,
    (a.rows + threadsPerBlock.y - 1) / threadsPerBlock.y);

    addVectors2D<<<numBlocks, threadsPerBlock>>>(d_a, d_b, d_c, a.cols);


    cudaMemcpy(flat_c, d_c, matSize, cudaMemcpyDeviceToHost);

    c.FromFLatArray(flat_c);

    printf("a matrix\n");
    a.PrintMatrix();
    printf("b matrix\n");
    b.PrintMatrix();
    printf("c matrix\n");
    c.PrintMatrix();

    free(flat_a);
    free(flat_b);
    free(flat_c);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}