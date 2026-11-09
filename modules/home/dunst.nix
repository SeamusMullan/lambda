# dunst notifications. Frame colour, bg/fg, font → Stylix. Geometry here.
{
  services.dunst = {
    enable = true;
    settings.global = {
      origin = "top-right";
      offset = "(12, 40)"; # below the 28px bar
      width = 360;
      height = "(0, 200)";
      gap_size = 6;
      frame_width = 2;
      corner_radius = 0; # Half-Life is square
      padding = 10;
      horizontal_padding = 12;
      timeout = 6;
      markup = "full";
      format = "<b>%s</b>\\n%b";
    };
  };
}
