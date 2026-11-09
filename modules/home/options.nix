# Shared knobs so modules don't hardcode each other's commands.
# i3 reads these; the app modules set them. Swap a tool → change one line.
{ lib, ... }:
{
  options.lambda = {
    terminal = lib.mkOption {
      type = lib.types.str;
      default = "kitty";
      description = "Command i3 runs for $mod+Return.";
    };
    launcher = lib.mkOption {
      type = lib.types.str;
      default = "rofi -show drun";
      description = "Command i3 runs for $mod+d. Overridden by modules/home/launcher.nix once your launcher is wired.";
    };
    browser = lib.mkOption {
      type = lib.types.str;
      default = "firefox";
      description = "Command i3 runs for $mod+b.";
    };
    wallpaperPicker = lib.mkOption {
      type = lib.types.str;
      default = "vista";
      description = "Command i3 runs for $mod+Shift+w.";
    };
  };
}
