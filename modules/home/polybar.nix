# polybar — top bar. Stylix has no polybar target, so colours + font are read from
# config.lib.stylix.colors / config.stylix.fonts at build time. Same scheme, never hardcoded.
{ config, pkgs, ... }:
let
  colors = config.lib.stylix.colors.withHashtag;
  fonts = config.stylix.fonts;
  barFont = "${fonts.monospace.name}:size=${toString fonts.sizes.desktop};3";
in
{
  services.polybar = {
    enable = true;
    package = pkgs.polybar.override {
      i3Support = true;
      pulseSupport = true;
    };
    # Started/restarted by i3 (modules/home/i3.nix) so it always sees the right DISPLAY.
    script = "polybar -q main &";

    settings = {
      "bar/main" = {
        width = "100%";
        height = 28;
        background = colors.base00;
        foreground = colors.base05;
        line-size = 2;
        padding = 1;
        module-margin = 1;
        font-0 = barFont;
        modules-left = "i3";
        modules-center = "date";
        modules-right = "pulseaudio memory cpu tray";
        wm-restack = "i3";
        enable-ipc = true;
      };

      "module/i3" = {
        type = "internal/i3";
        pin-workspaces = true;
        strip-wsnumbers = true;
        index-sort = true;

        label-focused = "%name%";
        label-focused-background = colors.base01;
        label-focused-underline = colors.base0D;
        label-focused-padding = 1;

        label-unfocused = "%name%";
        label-unfocused-foreground = colors.base04;
        label-unfocused-padding = 1;

        label-visible = "%name%";
        label-visible-underline = colors.base03;
        label-visible-padding = 1;

        label-urgent = "%name%";
        label-urgent-background = colors.base08;
        label-urgent-foreground = colors.base00;
        label-urgent-padding = 1;
      };

      "module/date" = {
        type = "internal/date";
        interval = 1;
        date = "%a %d %b";
        time = "%H:%M";
        label = "%date%  %time%";
        label-foreground = colors.base0D;
      };

      "module/cpu" = {
        type = "internal/cpu";
        interval = 2;
        label = "cpu %percentage%%";
      };

      "module/memory" = {
        type = "internal/memory";
        interval = 2;
        label = "mem %percentage_used%%";
      };

      "module/pulseaudio" = {
        type = "internal/pulseaudio";
        label-volume = "vol %percentage%%";
        label-muted = "muted";
        label-muted-foreground = colors.base03;
      };

      "module/tray" = {
        type = "internal/tray"; # polybar ≥ 3.7
        tray-spacing = 6;
      };
    };
  };
}
