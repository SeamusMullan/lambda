# Nix daemon settings. Flakes-only: no channels.
{ inputs, ... }:
{
  nix = {
    channel.enable = false; # pure flakes

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org" # home-manager, stylix deps
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      warn-dirty = false;
    };

    optimise.automatic = true; # hard-link identical store files; VM disks are small

    # `nix shell nixpkgs#foo` and legacy <nixpkgs> resolve to the SAME nixpkgs the system uses.
    registry.nixpkgs.flake = inputs.nixpkgs;
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  # nh: `nh os switch` → coloured diff of what changed. Also does GC, so nix.gc stays off.
  programs.nh = {
    enable = true;
    flake = "/home/carrrot/lambda"; # TODO: where you clone this repo on the VM
    clean = {
      enable = true;
      extraArgs = "--keep-since 14d --keep 5";
    };
  };

  nixpkgs.config.allowUnfree = true;
}
