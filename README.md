# omokoda-mesh-os

Custom Arch Linux foundation OS (archiso-based) for `omokoda-mesh` dual-radio
gateway/bridge nodes — the Raspberry Pi / Linux boxes that bridge LoRa mesh
traffic into Nostr relays, Reticulum, and on-chain settlement.

Part of the Ọmọ Kọ́dà / OSOVM / Vantage ecosystem. This is the gateway-side
counterpart to the `omokoda-mesh` ESP32 firmware repo, and reuses the same
"Arch/Omarchy as sovereign base" decision already locked for the portable
sovereign agent device (see memory: `omokoda-portable-device-full-spec`).
Gateway nodes are deliberately **not** agents — they don't run the birth
sequence or hold an IP Root, they just relay and bridge. Identity/birth
stays scoped to `omokoda-mesh` firmware nodes and the personal device spec.

## Status

Doc + scaffold stage. Not yet built or booted.

## Layout

- `profile/` — archiso profile (`packages.x86_64`, `profiledef.sh`,
  `pacman.conf`, `airootfs/`).
- `profile/airootfs/opt/omokoda-mesh-os/scripts/first-boot.sh` — one-shot
  setup run via `omokoda-mesh-first-boot.service`; prepares
  `/etc/omokoda-mesh/gateway.conf` for the bridge runtime. Deliberately does
  not generate any cryptographic identity.
- `build.sh` — wraps `mkarchiso`. Must run on Arch Linux (or an Arch
  container) with the `archiso` package installed.

## Build

```
./build.sh
```

Output ISO lands in `out/`.

## Related

- `omokoda-mesh` — the ESP32 mesh node firmware this OS bridges for.
