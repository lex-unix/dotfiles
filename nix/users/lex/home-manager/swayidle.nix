{
  lib,
  pkgs,
  ...
}:
let
  lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
  niri = "${pkgs.niri}/bin/niri";
in
{
  services.swayidle = lib.mkIf pkgs.stdenv.isLinux {
    enable = true;
    extraArgs = [ "-w" ];

    timeouts = [
      {
        timeout = 300;
        command = lock;
      }
      {
        timeout = 600;
        command = "${niri} msg action power-off-monitors";
        resumeCommand = "${niri} msg action power-on-monitors";
      }
    ];

    events = {
      before-sleep = lock;
      after-resume = "${niri} msg action power-on-monitors";
      lock = lock;
    };
  };
}
