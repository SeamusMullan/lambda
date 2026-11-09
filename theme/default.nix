# ╔══════════════════════════════════════════════════════════════════════╗
# ║  THEME — the only place colours, fonts, cursor and wallpaper live.   ║
# ║  Change here → rebuild → i3, rofi, dunst, kitty, GTK, Qt, Firefox,   ║
# ║  Chromium, lightdm, console follow via Stylix targets; polybar and   ║
# ║  Vista read config.lib.stylix.colors directly.                       ║
# ╚══════════════════════════════════════════════════════════════════════╝
#
# System-level Stylix. home-manager inherits all of this automatically
# (Stylix adds its HM module to every user). HM-only tweaks: ./home.nix
{ pkgs, config, ... }:
{
  stylix = {
    enable = true;
    autoEnable = true; # every supported target gets themed unless switched off in ./home.nix
    polarity = "dark";

    base16Scheme = ./half-life.yaml;

    # Stylix wants an image (lightdm background, palette.html preview).
    # The LIVE wallpaper is owned by Vista at runtime — see ./home.nix (feh target off).
    image = ./wallpapers/fallback.png;

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic"; # black
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.inter;
        name = "Inter";
      };
      serif = config.stylix.fonts.sansSerif;
      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 11;
        desktop = 11; # bar, i3 titles
        popups = 11; # dunst, rofi
        terminal = 12;
      };
    };

    opacity = {
      terminal = 0.95; # needs a compositor → modules/home/picom.nix
    };
  };
}
