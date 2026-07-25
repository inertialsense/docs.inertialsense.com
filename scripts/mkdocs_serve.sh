#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

URL="http://127.0.0.1:8000/"

mkdocs serve &
SERVE_PID=$!

for i in {1..30}; do
    curl -sSf "$URL" >/dev/null 2>&1 && break
    sleep 0.5
done

if command -v xdg-open >/dev/null 2>&1; then
    xdg-open "$URL" >/dev/null 2>&1 &
elif command -v open >/dev/null 2>&1; then
    open "$URL"
fi

wait "$SERVE_PID"