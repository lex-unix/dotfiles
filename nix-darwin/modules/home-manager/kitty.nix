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
    include ./themes/mellow.conf
  '';
}
