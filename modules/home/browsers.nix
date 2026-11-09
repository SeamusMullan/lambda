# Firefox (fully Stylix-themed via HM) + Chromium (open-source build, not Google Chrome).
# Chromium's theme colour is set by Stylix at the NixOS layer (programs.chromium.extraOpts policy);
# this file only installs it and forces dark mode.
#
# aarch64 + Chromium: check the binary cache BEFORE the first switch, or it compiles for hours in UTM:
#   nix build nixpkgs#chromium --dry-run      ← "will be fetched" = good, "will be built" = bad
# Fallback if it would build: pkgs.ungoogled-chromium, or comment Chromium out for now.
{ pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    profiles.default = {
      id = 0;
      isDefault = true;
      name = "default"; # ← stylix.targets.firefox.profileNames in theme/home.nix
      settings = {
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "layout.css.prefers-color-scheme.content-override" = 0; # 0 = dark: web pages respect the theme
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };

  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    commandLineArgs = [
      "--force-dark-mode"
      "--enable-features=WebUIDarkMode"
    ];
  };

  lambda.browser = "firefox";

  home.sessionVariables.BROWSER = "firefox";
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };
}
