{
  lib,
  isLinux,
  ...
}: {
  services.mako = lib.mkIf isLinux {
    enable = true;

    settings = {
      anchor = "top-right";
      width = 360;
      height = 140;
      margin = "12";
      padding = "12";
      border-size = 2;
      border-radius = 6;
      default-timeout = 5000;
      font = "SauceCodePro Nerd Font Mono 12";

      background-color = "#171819";
      text-color = "#d4be98";
      border-color = "#7daea3";
      progress-color = "over #3c3836";
    };
  };
}
