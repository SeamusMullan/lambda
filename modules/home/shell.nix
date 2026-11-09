# zsh + starship + CLI tools. fzf and bat are Stylix targets → themed automatically.
{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    autocd = true;
    history.size = 50000;
    shellAliases = {
      ll = "eza -la --git";
      cat = "bat";
      rebuild = "nh os switch"; # programs.nh.flake points at the repo
      lambda = "cd ~/lambda";
    };
  };

  programs.starship.enable = true;
  programs.fzf.enable = true;
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Carrrot"; # TODO
      user.email = "you@example.com"; # TODO
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    tree
    pavucontrol
  ];
}
