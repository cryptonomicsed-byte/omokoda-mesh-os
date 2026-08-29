#!/usr/bin/env bash
# omokoda-mesh-os archiso profile definition
# Built with: mkarchiso -v -w work/ -o out/ profile/

iso_name="omokoda-mesh-os"
iso_label="OMOKODA_MESH_$(date +%Y%m)"
iso_publisher="cryptonomicsed-byte <https://github.com/cryptonomicsed-byte>"
iso_application="omokoda-mesh-os gateway node live/install image"
iso_version="$(date +%Y.%m.%d)"
install_dir="omokoda"
buildmodes=('iso')
bootmodes=('bios.syslinux.mbr' 'bios.syslinux.eltorito'
           'uefi-x64.systemd-boot.esp' 'uefi-x64.systemd-boot.eltorito')
arch="x86_64"
pacman_conf="pacman.conf"
airootfs_image_type="squashfs"
airootfs_image_tool_options=('-comp' 'zstd' '-Xcompression-level' '19')
file_permissions=(
  ["/etc/shadow"]="0:0:0400"
  ["/root"]="0:0:0750"
  ["/root/.ssh"]="0:0:0700"
  ["/opt/omokoda-mesh-os/scripts/first-boot.sh"]="0:0:0755"
)
