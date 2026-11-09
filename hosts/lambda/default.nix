# Host: lambda — NixOS aarch64 guest in UTM (QEMU backend) on the MacBook.
# Host files answer "what is this machine". Behaviour lives in modules/.
{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos # core: nix settings, X11+i3, users, audio
    ../../modules/nixos/vm-guest.nix # hardware-specific: only this host
  ];

  nixpkgs.hostPlatform = "aarch64-linux";
  networking.hostName = "lambda";
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  time.timeZone = "Europe/Dublin";
  i18n.defaultLocale = "en_IE.UTF-8";

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    htop
    killall
    pciutils
    usbutils
    xdg-utils
  ];

  # TODO: copy the value from /etc/nixos/configuration.nix on the VM. Never bump it later.
  system.stateVersion = "26.05";
}
