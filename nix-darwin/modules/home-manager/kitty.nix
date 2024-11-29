{ pkgs, userConfig, ... }:
let
  mellowRepo = pkgs.fetchFromGitHub {
    owner = "mellow-theme";
    repo = "mellow.nvim";
    rev = "434a02d5f7637a24824569426176f37473205053";
    sha256 = "sha256-Lr4+KxQRsTJrqwGtRMcxBwDZq84v6Pl4NUcfu+5XhRs=";
  };

  gruvboxRepo = pkgs.fetchFromGitHub {
    owner = "lex-unix";
    repo = "gruvbox-material-kitty";
    rev = "ca7e17ed8e61c608f6f3ff480336c1232fcd3e23";
    sha256 = "sha256-CD09hZT/d4LV4eO7L7nqFThkXF5ECBzOzL+fhOVNp98=";
  };

  themes = {
    mellow = builtins.readFile "${mellowRepo}/extras/kitty/mellow.conf";
    gruvbox = builtins.readFile "${gruvboxRepo}/colors/gruvbox-material-dark-hard.conf";
    ayu = builtins.readFile "${gruvboxRepo}/colors/ayu.conf";
  };
in
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

  extraConfig = themes.${userConfig.theme};
}
