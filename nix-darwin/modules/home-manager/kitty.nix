{ pkgs, ... }:
{
  enable = true;

  shellIntegration = {
    enableFishIntegration = true;
    enableZshIntegration = true;
    mode = "enabled";
  };

  font = {
    name = "SauceCodePro Nerd Font Mono";
    size = 14.0;
  };

  settings = {
    cursor_shape = "block";
    cursor_blink_interval = 0;
    enable_audio_bell = "no";
    window_margin_width = 5;
    window_padding_width = 5;
    placement_strategy = "center";
    hide_window_decorations = "titlebar-only";
    confirm_os_window_close = 0;
    macos_option_as_alt = "yes";
    adjust_line_height = "120%";
    shell = "${pkgs.fish}/bin/fish";
  };

  keybindings = {
    "ctrl+shift+n" = "no_op";
    "ctrl+shift+p" = "no_op";
  };

  extraConfig = ''
    ### MELLOW THEME BEGIN
    background #161617
    foreground #c9c7cd
    cursor #e3e2e5
    selection_foreground #e3e2e5
    selection_background #3C3B3E
    active_tab_foreground   #cac9dd
    active_tab_background   #353539
    inactive_tab_foreground #57575f
    inactive_tab_background #1b1b1d
    active_border_color   #57575f
    inactive_border_color #2a2a2d
    inactive_text_alpha   1.0
    # Black
    color0  #27272a
    color8  #353539
    # Red
    color1  #f5a191
    color9  #ffae9f
    # Green
    color2  #90b99f
    color10 #9dc6ac
    # Yellow
    color3  #e6b99d
    color11 #f0c5a9
    # Blue
    color4  #aca1cf
    color12 #b9aeda
    # Magenta
    color5  #e29eca
    color13 #ecaad6
    # Cyan
    color6  #ea83a5
    color14 #f591b2
    # White
    color7  #c1c0d4
    color15 #cac9dd
    ### MELLOW THEME END

    ### GRUVBOX THEME START
    # background #171819
    # foreground #d4be98
    # selection_background #d4be98
    # selection_foreground #1d2021
    # cursor #a89984
    # cursor_text_color background
    # active_tab_background #1d2021
    # active_tab_foreground #d4be98
    # active_tab_font_style bold
    # inactive_tab_background #1d2021
    # inactive_tab_foreground #a89984
    # inactive_tab_font_style normal
    # # Black
    # color0 #665c54
    # color8 #928374
    # # Red
    # color1 #ea6962
    # color9 #ea6962
    # # Green
    # color2 #a9b665
    # color10 #a9b665
    # # Yellow
    # color3 #e78a4e
    # color11 #d8a657
    # # Blue
    # color4 #7daea3
    # color12 #7daea3
    # # Magenta
    # color5 #d3869b
    # color13 #d3869b
    # # Cyan
    # color6 #89b482
    # color14 #89b482
    # # White
    # color7 #d4be98
    # color15 #d4be98
    ### GRUVBOX THEME END
  '';
}
