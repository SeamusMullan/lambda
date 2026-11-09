# X server + i3 session + display manager. System half of the desktop.
# The i3 CONFIG (keybinds, bar, startup) lives in modules/home/i3.nix — home-manager writes ~/.config/i3/config.
# Colours/fonts for i3, lightdm, GTK and the console come from Stylix — nothing here.
{ pkgs, ... }:
{
  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];

    xkb = {
      layout = "ie"; # TODO: "us" / "gb" if that is what the VM is set to
      variant = "";
      options = ""; # e.g. "caps:escape"
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = [ ]; # dmenu/i3status not needed: rofi + polybar come from home-manager
    };

    displayManager.lightdm = {
      enable = true;
      greeters.gtk.enable = true; # Stylix themes this greeter
    };
  };

  services.displayManager = {
    defaultSession = "none+i3";
    autoLogin = {
      enable = true; # it's a VM on your own laptop; drop this on bare metal
      user = "carrrot";
    };
  };

  services.libinput.enable = true;

  hardware.graphics.enable = true;

  programs.dconf.enable = true; # GTK settings via home-manager need this
  security.polkit.enable = true; # GUI auth prompts; agent is started by i3 (modules/home/i3.nix)
}
