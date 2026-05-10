{
  lib,
  pkgs,
  ...
}:
{
  programs.fuzzel = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;

    settings = {
      main = {
        terminal = "ghostty";
        font = "SauceCodePro Nerd Font Mono:size=14";
        width = 42;
        lines = 12;
        horizontal-pad = 16;
        vertical-pad = 12;
        inner-pad = 8;
      };

      border = {
        width = 2;
        radius = 6;
      };

      colors = {
        background = "171819f0";
        text = "d4be98ff";
        match = "7daea3ff";
        selection = "3c3836ff";
        selection-text = "d4be98ff";
        selection-match = "89b482ff";
        border = "7daea3ff";
      };
    };
  };
}
