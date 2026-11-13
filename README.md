# Fastest primes

Run command:

```sh
./run.sh
```

It reads N from stdin and prints the count of primes less than or equal to N.

`run.sh` caches an optimized C build when `gcc` is available and otherwise runs the Python bytearray-sieve fallback.

Run the cases in `cases.json` plus the timed N=5,000,000 case with:

```sh
./test.sh
```
