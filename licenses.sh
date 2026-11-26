#!/usr/bin/env bash
set -euo pipefail

OUT=${1:-licenses-kai-server.csv}

SCRIPT=$(cat <<'PY'
import csv
import sys
from importlib.metadata import distributions

writer = csv.writer(sys.stdout, quoting=csv.QUOTE_ALL, lineterminator="\n")
for dist in sorted(distributions(), key=lambda d: (d.metadata["Name"] or "").lower()):
    meta = dist.metadata
    classifiers = "; ".join(c.split(" :: ")[-1] for c in meta.get_all("Classifier", []) if c.startswith("License ::"))
    first_line = (meta.get("License") or "").strip().split("\n")[0]
    license = meta.get("License-Expression") or classifiers or first_line or "UNKNOWN"
    writer.writerow([sys.argv[1], meta["Name"], meta["Version"], license])
PY
)

docker compose build -q

echo '"Image","Name","Version","License"' > "$OUT"
for img in $(docker compose config --images); do
  docker run --rm --entrypoint python3 "$img" -c "$SCRIPT" "$img" >> "$OUT"
done