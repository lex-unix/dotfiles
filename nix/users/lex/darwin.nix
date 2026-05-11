{ pkgs, currentSystemUser, ... }:
{
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
      "codex-app"
    ];
    masApps = {
      "Bear" = 1091189122;
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
