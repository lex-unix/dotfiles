{
  pkgs,
  currentSystemUser,
  ...
}: {
  homebrew = {
    enable = true;
    taps = [
      "nikitabobko/tap"
      "slashtable/cask"
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
      "slashtable"
      "httpie-desktop"
      "the-unarchiver"
      "thaw"
      "iina"
      "codex-app"
    ];
    masApps = {
      "Wipr" = 1320666476;
      "Parcel" = 639968404;
    };
  };

  system.primaryUser = currentSystemUser;

  users.users.${currentSystemUser} = {
    home = "/Users/${currentSystemUser}";
    shell = pkgs.fish;
  };
}
