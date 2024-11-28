{ pkgs, ... }:
{
  environment.shells = with pkgs; [
    fish
    zsh
    bash
  ];

  environment.systemPackages = with pkgs; [
    kitty
    nixfmt-rfc-style
  ];

  homebrew = {
    enable = true;
    brews = [
      "mas"
    ];
    casks = [
      "raycast"
      "1password"
      "karabiner-elements"
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
    (pkgs.nerdfonts.override {
      fonts = [ "SourceCodePro" ];
    })
  ];

  system.defaults = {
    finder.FXPreferredViewStyle = "clmv";
    NSGlobalDomain.AppleShowAllExtensions = true;
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

  users.users.lex = {
    home = "/Users/lex";
    shell = pkgs.fish;
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = "nix-command flakes";
}
