{ pkgs, ... }:
{
  # Don't touch this, Home Manager can be updated without changing this value
  home.stateVersion = "24.11";

  home.username = "lex";
  home.homeDirectory = "/Users/lex";

  home.packages = with pkgs; [
    jq
    fd
    ripgrep
    fzf
    btop
    eza
    zoxide
    wget
    coreutils
    jankyborders
  ];

  xdg.enable = true;

  programs = {
    starship = import ./starship.nix { inherit pkgs; };
    bat = import ./bat.nix { inherit pkgs; };
    fish = import ./fish.nix { inherit pkgs; };
    zoxide = import ./zoxide.nix { inherit pkgs; };
    kitty = import ./kitty.nix { inherit pkgs; };
    tmux = import ./tmux.nix { inherit pkgs; };
    fzf = import ./fzf.nix { inherit pkgs; };
    git = import ./git.nix { inherit pkgs; };
  };

  programs.home-manager.enable = true;
}
