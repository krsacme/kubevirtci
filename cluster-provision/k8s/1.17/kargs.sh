#!/bin/bash

set -ex

# OvS-DPDK requires latest kernel
yum update -y --nobest kernel

# provision.sh configures 2M hugepages, remove it and add 1G hugepage
# 1G hugepage is required for OvS-DPDK
sed -i '/^GRUB_CMDLINE_LINUX.*GRUB_CMDLINE_LINUX.*/d' /etc/default/grub
echo 'GRUB_CMDLINE_LINUX="${GRUB_CMDLINE_LINUX} spectre_v2=off nopti intel_iommu=on iommu=pt default_hugepagesz=1GB hugepagesz=1G hugepages=2"' >> /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg

