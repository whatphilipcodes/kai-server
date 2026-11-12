#!/bin/sh
set -eu
REPO=/root/.cache/huggingface/hub/models--mistralai--Voxtral-Mini-4B-Realtime-2602
SNAP="$REPO/snapshots/$(cat "$REPO/refs/main")"
DST=/models/voxtral

find "$DST" -mindepth 1 -delete
for f in "$SNAP"/*; do
  ln -s "$(readlink -f "$f")" "$DST/$(basename "$f")"
done
rm "$DST/tekken.json"

python3 -c '
import json, os, sys
c = json.load(open(sys.argv[1], encoding="utf-8"))
c["audio"]["transcription_delay_ms"] = int(os.environ["VOXTRAL_DELAY_MS"])
json.dump(c, open(sys.argv[2], "w", encoding="utf-8"))
print("audio config:", c["audio"], flush=True)
' "$SNAP/tekken.json" "$DST/tekken.json"