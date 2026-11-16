#!/bin/zsh
set -euo pipefail

PLIST_TARGET="${HOME}/Library/LaunchAgents/com.openterminal.server.plist"

launchctl bootout "gui/$(id -u)" "${PLIST_TARGET}" >/dev/null 2>&1 || true
rm -f "${PLIST_TARGET}"

echo "removed ${PLIST_TARGET}"
