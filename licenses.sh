#!/usr/bin/env bash
set -euo pipefail

SYFT_VERSION=v1.14.0
OUT=${1:-licenses-kai-server.csv}

docker compose pull --ignore-buildable -q 2>/dev/null || true
docker compose build -q

echo '"Image","Name","Version","License"' > "$OUT"
for img in $(docker compose config --images); do
  docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    "anchore/syft:${SYFT_VERSION}" "docker:${img}" -o syft-json -q \
  | docker run --rm -i ghcr.io/jqlang/jq:1.7.1 -r --arg img "$img" '
      .artifacts[]
      | [ $img, .name, .version,
          ( [ .licenses[].value ] | join(", ") ) ]
      | @csv' >> "$OUT"
done