# App launcher. rofi is the placeholder until your dmenu replacement is wired in.
#
# TO SWAP IN YOUR LAUNCHER:
#   1. flake.nix        → uncomment the `launcher` input, set the repo
#   2. overlays/default.nix → uncomment the overlay line
#   3. here             → replace the rofi block with the one below, set lambda.launcher
#
# Pass colours the way your launcher takes them. Three patterns:
#   a) config file   → xdg.configFile."<name>/config".text = ''...${colors.base00}...'';
#   b) Xresources    → xresources.properties = { "<name>.background" = colors.base00; … };
#   c) dmenu flags   → lambda.launcher = "<name> -nb ${colors.base00} -nf ${colors.base05} -sb ${colors.base0D} -sf ${colors.base00}";
{ config, pkgs, ... }:
let
  colors = config.lib.stylix.colors.withHashtag;
in
{
  # ── placeholder: rofi (Stylix themes it; do NOT set programs.rofi.theme) ──
  programs.rofi = {
    enable = true;
    settings = {
      modi = "drun,run,window";
      terminal = config.lambda.terminal;
      show-icons = true;
      drun-display-format = "{name}";
      display-drun = "run";
    };
  };
  lambda.launcher = "rofi -show drun";

  # ── your launcher (uncomment, delete the rofi block) ──
  # home.packages = [ pkgs.<launcher> ];
  # lambda.launcher = "<launcher> -nb ${colors.base00} -nf ${colors.base05} -sb ${colors.base0D} -sf ${colors.base00}";
}
