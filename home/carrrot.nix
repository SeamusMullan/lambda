# User entrypoint. Picks which modules this user gets; holds nothing else.
{
  imports = [
    ../theme/home.nix
    ../modules/home
  ];

  home = {
    username = "carrrot";
    homeDirectory = "/home/carrrot";
    stateVersion = "26.05"; # TODO: same value as system.stateVersion in hosts/lambda/default.nix
  };

  programs.home-manager.enable = true;
}
