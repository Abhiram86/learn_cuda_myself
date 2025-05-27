#include <cuda_runtime.h>

#include <stdio.h>

__global__ void addVectors1D(int* a, int *b, int *c, int n) {
    int i = threadIdx.x;
    if (i < n)
        c[i] = a[i] + b[i];
}

int main() {
    int *a, *b, *c, n = 6;
    a = (int*)malloc(sizeof(int) * n);
    b = (int*)malloc(sizeof(int) * n);
    c = (int*)malloc(sizeof(int) * n);

    for (int i = 0; i < n; i++) {
        printf("Enter value for a[%d]: ", i);
        scanf("%d", &a[i]);
    }
    
    for (int i = 0; i < n; i++) {
        printf("Enter value for b[%d]: ", i);
        scanf("%d", &b[i]);
    }
    
    int *d_a, *d_b, *d_c;
    cudaMalloc((void**)&d_a, sizeof(int) * n);
    cudaMalloc((void**)&d_b, sizeof(int) * n);
    cudaMalloc((void**)&d_c, sizeof(int) * n);

    cudaMemcpy(d_a, a, sizeof(int) * n, cudaMemcpyHostToDevice);
    cudaMemcpy(d_b, b, sizeof(int) * n, cudaMemcpyHostToDevice);

    addVectors1D<<<1, n>>>(d_a, d_b, d_c, n);

    cudaMemcpy(c, d_c, sizeof(int) * n, cudaMemcpyDeviceToHost);

    printf("\n");
    
    for (int i = 0; i < n; i++) {
        printf("%d ", c[i]);
    }

    free(a);
    free(b);
    free(c);

    cudaFree(d_a);
    cudaFree(d_b);
    cudaFree(d_c);

    return 0;
}