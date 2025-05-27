#pragma once
#include <stdio.h>
#include <stdlib.h>

struct Matrix {
    int rows;
    int cols;
    int **mat;
    Matrix(int rows, int cols) {
        this->rows = rows;
        this->cols = cols;
        mat = (int **)malloc(rows * cols * sizeof(int *));
        for (int i = 0; i < rows; i++) {
            mat[i] = (int *)malloc(cols * sizeof(int));
        }
    }
    int Get(int row, int col) {
        return this->mat[row][col];
    }
    void MatGetInput() {
        for (int i = 0; i < this->rows; i++) {
            for (int j = 0; j < this->cols; j++) {
                printf("Enter for mat[%d, %d] = ", i, j);
                scanf("%d", &this->mat[i][j]);
            }
        }
    }
    void FromFLatArray(int *arr) {
        for (int i = 0; i < this->rows; i++) {
            for (int j = 0; j < this->cols; j++) {
                this->mat[i][j] = arr[i * cols + j];
            }
        }
    }
    int *FlattenCopy() {
        int *tempMat = (int *)malloc(this->rows * this->cols * sizeof(int));
        for (int i = 0; i < this->rows; i++) {
            for (int j = 0; j < this->cols; j++) {
                tempMat[i * cols + j] = this->mat[i][j];
            }
        }
        return tempMat;
    }
    void PrintMatrix() {
        for(int i = 0; i < this->rows; i++) {
            for(int j = 0; j < this->cols; j++) {
                printf("%d ", this->Get(i, j));
            }
            printf("\n");
        }
    }
    ~Matrix() {
        for (int i = 0; i < rows; i++) {
            free(mat[i]);
        }
        free(mat);
    }
};