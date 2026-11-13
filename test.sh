#!/bin/sh
set -eu

cd "$(dirname "$0")"

python3 - <<'PY'
import json
import subprocess
import sys
import time


def run_case(n: int) -> int:
    result = subprocess.run(
        ["./run.sh"],
        input=f"{n}\n",
        text=True,
        capture_output=True,
    )
    if result.returncode != 0:
        print(f"FAIL N={n}: exit {result.returncode}: {result.stderr.strip()}", file=sys.stderr)
        raise SystemExit(1)
    try:
        return int(result.stdout.strip())
    except ValueError:
        print(f"FAIL N={n}: invalid output {result.stdout!r}", file=sys.stderr)
        raise SystemExit(1)


with open("cases.json", encoding="utf-8") as cases_file:
    cases = json.load(cases_file)

passed = 0
for case in cases:
    n = int(case["n"])
    expected = int(case["count"])
    actual = run_case(n)
    if actual != expected:
        print(f"FAIL N={n}: expected {expected}, got {actual}", file=sys.stderr)
        raise SystemExit(1)
    print(f"PASS N={n}: {actual}")
    passed += 1

n = 5_000_000
expected = 348_513
started = time.perf_counter()
actual = run_case(n)
elapsed = time.perf_counter() - started
if actual != expected:
    print(f"FAIL N={n}: expected {expected}, got {actual}", file=sys.stderr)
    raise SystemExit(1)
print(f"PASS N={n}: {actual} ({elapsed:.6f}s wall)")
passed += 1
print(f"{passed} cases passed")
PY
