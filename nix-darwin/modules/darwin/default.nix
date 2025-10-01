{ pkgs, userConfig, ... }:
{
  environment.shells = with pkgs; [
    fish
    zsh
    bash
  ];

  environment.systemPackages = with pkgs; [
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
      "ghostty"
      "raycast"
      "1password"
      "karabiner-elements"
      "aerospace"
      "spotify"
      "orbstack"
      "firefox"
      "telegram"
      "slack"
      "tableplus"
      "httpie-desktop"
      "the-unarchiver"
      "jordanbaird-ice"
      "iina"
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
  programs.bash.enable = true;

  system.primaryUser = userConfig.username;

  system.configurationRevision = null;

  system.stateVersion = 5;

  security.pam.services.sudo_local.touchIdAuth = true;

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
      "/Applications/Ghostty.app"
    ];
  };

  users.users.${userConfig.username} = {
    home = "/Users/${userConfig.username}";
    shell = pkgs.fish;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = "nix-command flakes";
}
