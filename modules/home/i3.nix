# i3 behaviour: keybinds, workspaces, startup. Zero colours, zero fonts — Stylix sets those.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  mod = "Mod4"; # Super / Cmd
  inherit (config.lambda)
    terminal
    launcher
    browser
    wallpaperPicker
    ;

  # Restore Vista's last wallpaper (feh writes ~/.fehbg on every change). Fall back to the theme image.
  restoreWallpaper = ''test -x "$HOME/.fehbg" && "$HOME/.fehbg" || ${pkgs.feh}/bin/feh --bg-fill ${config.stylix.image}'';

  screenshot = "${pkgs.maim}/bin/maim -s -u | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
in
{
  home.packages = with pkgs; [
    feh
    maim
    xclip
  ];

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      modifier = mod;
      inherit terminal;
      menu = launcher;

      # colors / fonts → Stylix (stylix.targets.i3)

      bars = [ ]; # polybar instead (modules/home/polybar.nix)

      gaps = {
        inner = 8;
        outer = 4;
        smartGaps = true;
        smartBorders = "on";
      };

      window = {
        border = 2;
        titlebar = false;
        hideEdgeBorders = "smart";
      };
      floating = {
        border = 2;
        titlebar = false;
        modifier = mod;
      };

      focus.followMouse = true;
      workspaceAutoBackAndForth = true;

      keybindings = lib.mkOptionDefault {
        # apps
        "${mod}+Return" = "exec ${terminal}";
        "${mod}+d" = "exec ${launcher}";
        "${mod}+b" = "exec ${browser}";
        "${mod}+Shift+w" = "exec ${wallpaperPicker}";
        "${mod}+Shift+s" = "exec --no-startup-id ${screenshot}";
        "${mod}+Shift+q" = "kill";

        # focus — vim keys
        "${mod}+h" = "focus left";
        "${mod}+j" = "focus down";
        "${mod}+k" = "focus up";
        "${mod}+l" = "focus right";
        "${mod}+Shift+h" = "move left";
        "${mod}+Shift+j" = "move down";
        "${mod}+Shift+k" = "move up";
        "${mod}+Shift+l" = "move right";

        # layout
        "${mod}+v" = "split v";
        "${mod}+g" = "split h";
        "${mod}+f" = "fullscreen toggle";
        "${mod}+s" = "layout stacking";
        "${mod}+w" = "layout tabbed";
        "${mod}+e" = "layout toggle split";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+a" = "focus parent";
        "${mod}+minus" = "scratchpad show";
        "${mod}+Shift+minus" = "move scratchpad";

        # session
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+Shift+e" = "exec i3-msg exit";
        "${mod}+r" = "mode resize";

        # audio (PipeWire)
        "XF86AudioRaiseVolume" = "exec --no-startup-id ${wpctl} set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+";
        "XF86AudioLowerVolume" = "exec --no-startup-id ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute" = "exec --no-startup-id ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };

      modes.resize = {
        "h" = "resize shrink width 10 px or 5 ppt";
        "j" = "resize grow height 10 px or 5 ppt";
        "k" = "resize shrink height 10 px or 5 ppt";
        "l" = "resize grow width 10 px or 5 ppt";
        "Return" = "mode default";
        "Escape" = "mode default";
      };

      startup = [
        {
          command = "systemctl --user restart polybar";
          always = true;
          notification = false;
        }
        {
          command = restoreWallpaper;
          always = true;
          notification = false;
        }
        {
          command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          notification = false;
        }
      ];
    };
  };
}
