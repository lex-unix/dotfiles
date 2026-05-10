{
  lib,
  pkgs,
  ...
}:
{
  services.polkit-gnome = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
  };
}
