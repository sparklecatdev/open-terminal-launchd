# OpenTerminal

Silent `launchd` wrapper for:

```sh
$OPEN_TERMINAL_BIN run \
  --host 127.0.0.1 \
  --port 8000 \
  --api-key "$OPEN_TERMINAL_API_KEY"
```

## Run it now

```sh
export OPEN_TERMINAL_API_KEY='your-secret-key'
export OPEN_TERMINAL_BIN="$HOME/.local/bin/open-terminal"
./scripts/run-server.sh
```

## Start silently at boot

Install the user launch agent:

```sh
export OPEN_TERMINAL_API_KEY='your-secret-key'
export OPEN_TERMINAL_BIN="$HOME/.local/bin/open-terminal"
./scripts/install-launch-agent.sh
```

Remove it:

```sh
./scripts/uninstall-launch-agent.sh
```

The launch agent binds to `127.0.0.1:8000` and sends stdout and stderr to `/dev/null`.
