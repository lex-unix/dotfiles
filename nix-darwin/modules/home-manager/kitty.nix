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
    rev = "4093535c29d4e14bdd8b59fa6042253c3fd75cf0";
    sha256 = "sha256-C9t8ax4E1Dj0/NN7CS1Z+WKasun6wwqKru+LWClLaCc=";
  };

  themes = {
    mellow = builtins.readFile "${mellowRepo}/extras/kitty/mellow.conf";
    gruvbox = builtins.readFile "${gruvboxRepo}/colors/gruvbox-material-dark-hard.conf";
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
