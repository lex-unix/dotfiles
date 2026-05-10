{
  lib,
  pkgs,
  ...
}:
{
  programs.swaylock = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;

    settings = {
      color = "171819";
      font = "SauceCodePro Nerd Font Mono";
      indicator-idle-visible = false;
      indicator-radius = 120;
      ring-color = "3c3836";
      ring-ver-color = "7daea3";
      ring-wrong-color = "ea6962";
      key-hl-color = "89b482";
      line-color = "00000000";
      inside-color = "00000000";
      separator-color = "00000000";
      text-color = "d4be98";
    };
  };
}
