#!/usr/bin/env bash
# omokoda-mesh-os gateway first-boot setup.
# Runs once (guarded by omokoda-mesh-first-boot.service). Prepares a fresh
# gateway node: identity generation is intentionally NOT done here — gateway
# nodes bridge/relay, they don't birth agents. Identity/birth belongs to the
# omokoda-mesh firmware nodes and the portable sovereign agent device spec
# (see memory: omokoda-portable-device-full-spec). This script only sets up
# the bridge runtime environment.
set -euo pipefail

mkdir -p /var/lib/omokoda
mkdir -p /etc/omokoda-mesh

if [ ! -f /etc/omokoda-mesh/gateway.conf ]; then
  cat > /etc/omokoda-mesh/gateway.conf <<'EOF'
# omokoda-mesh gateway bridge config
# Filled in manually or by provisioning tooling — no defaults assumed.
NOSTR_RELAYS=
RETICULUM_CONFIG_DIR=/etc/reticulum
BRIDGE_LOG_LEVEL=info
EOF
fi

touch /var/lib/omokoda/first-boot-done
