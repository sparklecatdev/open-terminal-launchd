#!/bin/zsh
set -euo pipefail

API_KEY="${OPEN_TERMINAL_API_KEY:-}"

if [[ -z "${API_KEY}" ]]; then
  echo "set OPEN_TERMINAL_API_KEY before starting" >&2
  exit 1
fi

OPEN_TERMINAL_BIN="${OPEN_TERMINAL_BIN:-${HOME}/.local/bin/open-terminal}"

exec "${OPEN_TERMINAL_BIN}" run \
  --host 127.0.0.1 \
  --port 8000 \
  --api-key "${API_KEY}"
