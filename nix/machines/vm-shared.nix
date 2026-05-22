{
  pkgs,
  currentSystem,
  ...
}: {
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # VMware, Parallels both only support this being 0 otherwise you see
  # "error switching console mode" on boot.
  boot.loader.systemd-boot.consoleMode = "0";

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Kyiv";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  users.mutableUsers = false;
  security.sudo.wheelNeedsPassword = false;

  fonts.packages = [
    pkgs.nerd-fonts.sauce-code-pro
  ];

  environment.systemPackages = with pkgs; [
    vim
    killall
    gtkmm3
    gnumake
    xwayland-satellite
    gcc
  ];

  programs.niri.enable = true;

  security.polkit.enable = true;
  security.pam.services.swaylock = {};

  services.xserver.xkb = {
    layout = "us";
    options = "ctrl:nocaps";
  };
  services.displayManager.sddm.enable = false;
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation_timeout_sec = 30;
      bigclock = "en";
      clock = "%H:%M";
      hide_borders = true;
      hide_key_hints = true;
      initial_info_text = "nixos";
      load = true;
      save = true;
    };
  };
  services.desktopManager.plasma6.enable = false;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.tailscale.enable = true;

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = true;
  services.openssh.settings.PermitRootLogin = "no";

  system.stateVersion = "25.05";
}
