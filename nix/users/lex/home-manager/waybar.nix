{
  lib,
  isLinux,
  ...
}:
{
  programs.waybar = lib.mkIf isLinux {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 8;

        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];
        modules-center = [ "clock" ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "tray"
        ];

        "niri/workspaces" = {
          format = "{index}";
        };

        "niri/window" = {
          format = "{}";
          max-length = 80;
        };

        clock = {
          format = "{:%a %d %b  %H:%M}";
          tooltip-format = "{:%Y-%m-%d}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "muted";
          format-icons = {
            default = [
              "vol"
              "vol"
              "vol"
            ];
          };
        };

        network = {
          format-wifi = "{essid}";
          format-ethernet = "ethernet";
          format-disconnected = "offline";
          tooltip-format = "{ifname}";
        };

        battery = {
          format = "{capacity}%";
          format-charging = "{capacity}% charging";
          states = {
            warning = 30;
            critical = 15;
          };
        };

        tray = {
          spacing = 8;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "SauceCodePro Nerd Font Mono";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: #171819;
        color: #d4be98;
      }

      #workspaces button {
        color: #928374;
        padding: 0 8px;
      }

      #workspaces button.active {
        color: #171819;
        background: #7daea3;
      }

      #window,
      #clock,
      #pulseaudio,
      #network,
      #battery,
      #tray {
        padding: 0 10px;
      }

      #battery.warning {
        color: #d8a657;
      }

      #battery.critical {
        color: #ea6962;
      }
    '';
  };
}
