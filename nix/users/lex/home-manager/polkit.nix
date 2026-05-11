{
  lib,
  isLinux,
  ...
}:
{
  services.polkit-gnome = lib.mkIf isLinux {
    enable = true;
  };
}
