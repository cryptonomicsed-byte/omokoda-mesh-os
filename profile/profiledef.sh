#!/usr/bin/env bash
# omokoda-mesh-os archiso profile definition
# Built with: mkarchiso -v -w work/ -o out/ profile/
#
# NOTE: bootmodes use the CURRENT archiso names. The previous values
# ('bios.syslinux.mbr', 'bios.syslinux.eltorito', 'uefi-x64.systemd-boot.esp',
# 'uefi-x64.systemd-boot.eltorito') are deprecated and fail validation on
# current archiso — see the bootloader trees under syslinux/ and efiboot/.

iso_name="omokoda-mesh-os"
# Kept at <=16 chars: a longer label overflows Joliet and makes xorriso warn
# ("-volid text is too long for Joliet"). The old value appended $(date +%Y%m),
# which produced 19 chars.
iso_label="OMOKODA_MESH"
iso_publisher="cryptonomicsed-byte <https://github.com/cryptonomicsed-byte>"
iso_application="omokoda-mesh-os gateway node live/install image"
iso_version="$(date +%Y.%m.%d)"
install_dir="omokoda"
buildmodes=('iso')
bootmodes=('bios.syslinux'
           'uefi.systemd-boot')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '19')
bootstrap_tarball_compression=('zstd' '-c' '-T0' '--auto-threads=logical' '--long' '-19')
file_permissions=(
  ["/etc/shadow"]="0:0:0400"
  ["/root"]="0:0:0750"
  ["/root/.ssh"]="0:0:0700"
  ["/opt/omokoda-mesh-os/scripts/first-boot.sh"]="0:0:0755"
)
