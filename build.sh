#!/usr/bin/env bash
# Build the omokoda-mesh-os ISO. Must run on Arch Linux (or an Arch
# container) with archiso installed: `pacman -S archiso`.
set -euo pipefail

cd "$(dirname "$0")"
sudo mkarchiso -v -w work/ -o out/ profile/
