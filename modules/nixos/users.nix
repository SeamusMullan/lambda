{ pkgs, ... }:
{
  users.users.carrrot = {
    isNormalUser = true;
    description = "Carrrot";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
    ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true; # system-level enable; user config is modules/home/shell.nix
}
