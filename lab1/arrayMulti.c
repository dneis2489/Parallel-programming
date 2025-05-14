#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void sse(float a[], float b[], float c[]) {
    asm volatile (
                  "movups %[a], %%xmm0\n"
                  "movups %[b], %%xmm1\n"
                  "mulps %%xmm1, %%xmm0\n"
                  "movups %%xmm0, %[c]\n"
                  :
                  : [a]"m"(*a), [b]"m"(*b), [c]"m"(*c)
                  : "%xmm0", "%xmm1");
}

void multiply_sequential(float a[], float b[], float c[]) {
    for (int i = 0; i < 4; i++) {
         c[i] = a[i] * b[i];
    }
}
  
int main(int argc, char** argv) {
    int iterations_num = atoi(argv[1]);
    float a[4] = {1.0f, 2.0f, 3.0f, 4.0f};
    float b[4] = {5.0f, 6.0f, 7.0f, 8.0f};
    float c[4] = {0};

    clock_t start = clock();
    for (int i = 0; i < iterations_num; i++) {
      sse(a, b, c);
    }
    clock_t end = clock();
    double time_sse = (double)(end - start) / CLOCKS_PER_SEC;

    float d[4] = {0};
    start = clock();
    for (int i = 0; i < iterations_num; i++) {
        multiply_sequential(a, b, d);
    }
    end = clock();
    double time_seq = (double)(end - start) / CLOCKS_PER_SEC;

    printf("SSE Result: ");
    for (int i = 0; i < 4; i++) {
        printf("%.2f ", c[i]);
    }

    printf("\nSequential Result: ");
    for (int i = 0; i < 4; i++) {
        printf("%.2f ", d[i]);
    }

    printf("\nSSE: %.6f seconds\n", time_sse);
    printf("Простое умножение: %.6f seconds\n", time_seq);
    
    return 0;
}