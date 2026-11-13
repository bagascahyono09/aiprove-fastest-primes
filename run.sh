#!/bin/sh
set -eu

cd "$(dirname "$0")"

if command -v gcc >/dev/null 2>&1; then
    if [ ! -x ./primes ] || [ ./primes.c -nt ./primes ]; then
        gcc -O3 -o primes primes.c
    fi
    exec ./primes
fi

exec python3 primes.py
