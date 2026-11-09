# kitty — font, colours, opacity come from Stylix. Behaviour only here.
{
  programs.kitty = {
    enable = true;
    settings = {
      confirm_os_window_close = 0;
      enable_audio_bell = false;
      window_padding_width = 8;
      scrollback_lines = 10000;
      cursor_shape = "beam";
      cursor_blink_interval = 0;
      copy_on_select = "clipboard";
      strip_trailing_spaces = "smart";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };
    keybindings = {
      "ctrl+shift+t" = "new_tab_with_cwd";
      "ctrl+shift+enter" = "new_window_with_cwd";
    };
  };

  lambda.terminal = "kitty";
}
