#!/bin/zsh
set -euo pipefail

SCRIPT_DIR=${0:A:h}
ROOT_DIR=${SCRIPT_DIR:h}
PLIST_SOURCE="${ROOT_DIR}/launchd/com.openterminal.server.plist.template"
PLIST_TARGET="${HOME}/Library/LaunchAgents/com.openterminal.server.plist"
OPEN_TERMINAL_BIN="${OPEN_TERMINAL_BIN:-${HOME}/.local/bin/open-terminal}"
API_KEY="${OPEN_TERMINAL_API_KEY:-}"

if [[ ! -x "${OPEN_TERMINAL_BIN}" ]]; then
  echo "missing executable: ${OPEN_TERMINAL_BIN}" >&2
  exit 1
fi

if [[ -z "${API_KEY}" ]]; then
  echo "set OPEN_TERMINAL_API_KEY before running this script" >&2
  exit 1
fi

mkdir -p "${HOME}/Library/LaunchAgents"
sed \
  -e "s|__ROOT__|${ROOT_DIR}|g" \
  -e "s|__OPEN_TERMINAL__|${OPEN_TERMINAL_BIN}|g" \
  -e "s|__API_KEY__|${API_KEY}|g" \
  -e "s|__PATH__|${PATH}|g" \
  "${PLIST_SOURCE}" > "${PLIST_TARGET}"

launchctl bootout "gui/$(id -u)" "${PLIST_TARGET}" >/dev/null 2>&1 || true
launchctl bootstrap "gui/$(id -u)" "${PLIST_TARGET}"
launchctl enable "gui/$(id -u)/com.openterminal.server"
launchctl kickstart -k "gui/$(id -u)/com.openterminal.server"

echo "installed ${PLIST_TARGET}"
