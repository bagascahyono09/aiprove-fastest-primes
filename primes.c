#include <stdio.h>
#include <stdlib.h>

int main(void) {
    int n;

    setvbuf(stdin, NULL, _IOFBF, 1 << 16);
    setvbuf(stdout, NULL, _IOFBF, 1 << 16);

    if (scanf("%d", &n) != 1) {
        return 1;
    }
    if (n < 2) {
        puts("0");
        return 0;
    }

    /* Index i represents the odd number 2*i + 3. */
    size_t odd_count = ((size_t)n - 1) / 2;
    unsigned char *composite = calloc(odd_count, sizeof(*composite));
    if (odd_count != 0 && composite == NULL) {
        return 1;
    }

    for (size_t i = 0;; ++i) {
        size_t p = 2 * i + 3;
        if (p > (size_t)n / p) {
            break;
        }
        if (composite[i] == 0) {
            size_t start = (p * p - 3) / 2;
            for (size_t j = start; j < odd_count; j += p) {
                composite[j] = 1;
            }
        }
    }

    size_t count = 1; /* Count prime 2 separately. */
    for (size_t i = 0; i < odd_count; ++i) {
        count += composite[i] == 0;
    }

    free(composite);
    printf("%zu\n", count);
    return 0;
}
