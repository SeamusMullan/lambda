# GTK + Qt toggles. Theme, icons, cursor, fonts are all injected by Stylix; this just turns the HM modules on.
{
  gtk.enable = true;

  # Qt: Stylix's qt target enables qt.enable and sets platform theme + style itself. Nothing to do.

  xdg.enable = true;
  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
