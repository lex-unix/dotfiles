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

  environment.shellAliases = {
    nix-rebuild = "darwin-rebuild switch --flake ~/dotfiles/nix-darwin";
  };

  programs.fish.enable = true;
  programs.zsh.enable = true;

  system.configurationRevision = null;

  system.stateVersion = 5;

  system.defaults = {
    finder.FXPreferredViewStyle = "clmv";
    NSGlobalDomain.AppleShowAllExtensions = true;
  };

  fonts.packages = [
    (pkgs.nerdfonts.override {
      fonts = [ "SourceCodePro" ];
    })
  ];

  system.defaults.dock = {
    autohide = true;
    persistent-apps = [
      "/Applications/Firefox.app"
      "/Applications/Spotify.app"
      "/Applications/Bear.app"
      "/Applications/kitty.app"
    ];
  };

  users.users.lex = {
    home = "/Users/lex";
    shell = pkgs.fish;
  };

  nixpkgs.hostPlatform = "aarch64-darwin";
  nix.settings.experimental-features = "nix-command flakes";
}
