# Home-manager-level Stylix tweaks. Colours/fonts are INHERITED from ./default.nix — do not repeat them here.
# Only target switches and HM-only options belong in this file.
{ pkgs, ... }:
{
  stylix = {
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      dark = "Papirus-Dark";
      light = "Papirus-Light";
    };

    targets = {
      # Not a GNOME system. Stylix would otherwise fetch gnome-shell sources just to build a CSS theme nobody loads.
      gnome.enable = false;

      # Vista owns the wallpaper at runtime. If Stylix also ran feh on login it would
      # overwrite whatever you picked. modules/home/i3.nix restores Vista's last pick via ~/.fehbg.
      feh.enable = false;

      firefox = {
        profileNames = [ "default" ]; # must match programs.firefox.profiles.<name>
        colorTheme.enable = true; # full UI chrome in scheme colours. If this line errors, delete it.
      };
    };
  };
}
