{
  lib,
  pkgs,
  isLinux,
  ...
}:
{
  programs.swaylock = lib.mkIf isLinux {
    enable = true;
    package = pkgs.swaylock-effects;

    settings = {
      color = "171819";
      font = "SauceCodePro Nerd Font Mono";
      image = "~/Pictures/wallpaper.png";
      indicator-idle-visible = true;
      indicator-radius = 120;
      clock = true;
      timestr = "%R";
      datestr = "%a, %e of %B";
      ring-color = "d4be98";
      ring-ver-color = "7daea3";
      ring-wrong-color = "ea6962";
      key-hl-color = "89b482";
      line-color = "00000000";
      inside-color = "00000000";
      separator-color = "00000000";
      text-color = "d4be98";
      inside-ver-color = "00000000";
      inside-wrong-color = "00000000";
      text-ver = "";
      text-wrong = "";
    };
  };
}
