{
  pkgs,
  currentSystemName,
  currentTheme,
  ...
}:
{
  environment.shells = with pkgs; [
    fish
    zsh
    bash
  ];

  environment.systemPackages = with pkgs; [
    nixfmt
  ];

  environment.shellAliases = {
    nix-rebuild = "sudo darwin-rebuild switch --flake ~/dotfiles/nix-darwin#${currentSystemName}";
  };

  programs.fish.enable = true;
  programs.zsh.enable = true;
  programs.bash.enable = true;

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
      AppleInterfaceStyle = if currentTheme == "dark" then "Dark" else "Light";
      AppleInterfaceStyleSwitchesAutomatically = false;
    };
  };

  system.defaults.dock = {
    autohide = true;
    persistent-apps = [
      "/Applications/Helium.app"
      "/Applications/Spotify.app"
      "/Applications/Ghostty.app"
    ];
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  nix = {
    settings = {
      experimental-features = "nix-command flakes";
    };
    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 0;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };
  };
}
