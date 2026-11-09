# Every user-level module. Add a file → add a line.
# RULE: no hex colours, no font names in any of these. Need a colour?
#   config.lib.stylix.colors.withHashtag.base0D   (see polybar.nix / vista.nix)
{
  imports = [
    ./options.nix
    ./i3.nix
    ./polybar.nix
    ./launcher.nix
    ./vista.nix
    ./kitty.nix
    ./browsers.nix
    ./dunst.nix
    ./picom.nix
    ./gtk.nix
    ./shell.nix
  ];
}
