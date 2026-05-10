{
  pkgs,
  currentSystem,
  ...
}:
{
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
  ];

  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  system.stateVersion = "25.05";
}
