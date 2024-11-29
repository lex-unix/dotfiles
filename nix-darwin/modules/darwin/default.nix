{ pkgs, userConfig, ... }:
{
  environment.shells = with pkgs; [
    fish
    zsh
    bash
  ];

  environment.systemPackages = with pkgs; [
    neovim
    kitty
    nixfmt-rfc-style
  ];

  homebrew = {
    enable = true;
    taps = [
      "nikitabobko/tap"
    ];
    brews = [
      "mas"
    ];
    casks = [
      "raycast"
      "1password"
      "karabiner-elements"
      "aerospace"
      "spotify"
      "telegram"
      "slack"
      "tableplus"
      "httpie"
      "the-unarchiver"
      "jordanbaird-ice"
    ];
    masApps = {
      "Bear" = 1091189122;
      "Wipr" = 1320666476;
      "Parcel" = 639968404;
    };
  };

  environment.shellAliases = {
    nix-rebuild = "darwin-rebuild switch --flake ~/dotfiles/nix-darwin";
  };

  programs.fish.enable = true;
  programs.zsh.enable = true;

  system.configurationRevision = null;

  system.stateVersion = 5;

  security.pam.enableSudoTouchIdAuth = true;

  fonts.packages = [
    pkgs.nerd-fonts.sauce-code-pro
  ];

  system.defaults = {
    finder.FXPreferredViewStyle = "clmv";
    NSGlobalDomain = {
      AppleShowAllExtensions = true;
      # KeyRepeat:  120, 90, 60, 30, 12, 6, 2
      KeyRepeat = 2;
      # InitialKeyRepeat: 120, 94, 68, 35, 25, 15
      InitialKeyRepeat = 25;
      AppleInterfaceStyle = "Dark";
      AppleInterfaceStyleSwitchesAutomatically = false;
    };
  };

  system.defaults.dock = {
    autohide = true;
    persistent-apps = [
      "/Applications/Firefox.app"
      "/Applications/Spotify.app"
      "/Applications/Bear.app"
      "${pkgs.kitty}/Applications/kitty.app"
    ];
  };

  users.users.${userConfig.username} = {
    home = "/Users/${userConfig.username}";
    shell = pkgs.fish;
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = "nix-command flakes";
}
