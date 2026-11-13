#!/usr/bin/env python3
import sys


def count_primes(n: int) -> int:
    if n < 2:
        return 0

    # Index i represents the odd number 2*i + 3.
    odd_count = (n - 1) // 2
    composite = bytearray(odd_count)

    i = 0
    while True:
        p = 2 * i + 3
        if p * p > n:
            break
        if composite[i] == 0:
            start = (p * p - 3) // 2
            marks = (odd_count - 1 - start) // p + 1
            composite[start::p] = b"\x01" * marks
        i += 1

    return 1 + odd_count - sum(composite)


def main() -> int:
    values = sys.stdin.buffer.read().split()
    if not values:
        return 1
    print(count_primes(int(values[0])))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
