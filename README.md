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

**Builds and boots.** Verified on x86_64:

```
omokoda-mesh-os-<version>-x86_64.iso       626M
ISO 9660 ... 'OMOKODA_MESH' (bootable)     El Torito BIOS + UEFI, isohybrid MBR+GPT
Arch Linux 7.2.6-arch2-1 (ttyS0)  ->  archiso login:      zero failed units
[  OK  ] Finished omokoda-mesh-os gateway first-boot setup.
```

Not yet exercised: **UEFI boot** (the UEFI entry is present and valid; only BIOS has
been booted) and the **bridge runtime** against the generated `gateway.conf`.

### Known gaps

- `RETICULUM_CONFIG_DIR` is referenced by `first-boot.sh` but **Reticulum is not in
  `packages.x86_64`** — add `python-rns` (or equivalent) before that path does anything.
- PXE hooks (`archiso_pxe_nbd/nfs/http`) remain in the mkinitcpio `HOOKS` and pull
  dependencies (`ipconfig`, `nbd-client`, `nfsmount`) that are not packaged, producing
  non-fatal build warnings. Trim the hooks if PXE boot is not wanted.
- Inherited from the archiso releng reference profile and **not yet reviewed for a
  deployed gateway node**: tty1 autologin, `sshd` enabled, cloud-init units, Hyper-V /
  VMware / VirtualBox guest tools, livecd helpers. Correct for an install medium;
  needs a deliberate decision for a production image.

### Build requirements

`mkarchiso` requires **x86_64** — it cannot run on arm64/Termux. Build on Arch or in a
privileged Arch container:

```
docker run --rm --privileged \
  -v "$PWD":/src -v "$PWD/work":/work -v "$PWD/out":/out \
  archlinux:latest bash -c 'pacman -Sy --noconfirm --needed archiso && \
    mkarchiso -v -w /work -o /out /src/profile'
```

Needs roughly 3-5GB of free space; the ISO lands in `out/`. The image is built with
`zstd -19`, so expect the squashfs step to be slow on a low-core host.


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
