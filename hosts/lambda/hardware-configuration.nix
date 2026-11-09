# ┌──────────────────────────────────────────────────────────────────────────┐
# │ PLACEHOLDER — REPLACE BEFORE FIRST BUILD                                │
# │                                                                          │
# │   cp /etc/nixos/hardware-configuration.nix hosts/lambda/                 │
# │                                                                          │
# │ The values below are typical for a UTM/QEMU aarch64 guest but your disk  │
# │ labels / UUIDs will differ. The generated file wins.                     │
# └──────────────────────────────────────────────────────────────────────────┘
{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/profiles/qemu-guest.nix") ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "virtio_pci"
    "virtio_scsi"
    "usbhid"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/boot";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
