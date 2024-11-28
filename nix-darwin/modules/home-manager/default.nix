{ config, pkgs, ... }:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  # Don't touch this, Home Manager can be updated without changing this value
  home.stateVersion = "24.11";

  home.username = "lex";
  home.homeDirectory = "/Users/lex";

  home.packages = with pkgs; [
    jq
    fd
    btop
    eza
    zoxide
    wget
    coreutils
    jankyborders
    awscli2
  ];

  xdg = {
    enable = true;
    configFile.nvim.source = mkOutOfStoreSymlink "/Users/lex/dotfiles/nvim";
    configFile."karabiner/karabiner.json".source = mkOutOfStoreSymlink "/Users/lex/dotfiles/karabiner/karabiner.json";
  };

  programs = {
    starship = import ./starship.nix { inherit pkgs; };
    bat = import ./bat.nix { inherit pkgs; };
    fish = import ./fish.nix { inherit pkgs; };
    zoxide = import ./zoxide.nix { inherit pkgs; };
    kitty = import ./kitty.nix { inherit pkgs; };
    tmux = import ./tmux.nix { inherit pkgs; };
    fzf = import ./fzf.nix { inherit pkgs; };
    git = import ./git.nix { inherit pkgs; };
    ripgrep = import ./ripgrep.nix { inherit pkgs; };
    fd = import ./fd.nix { inherit pkgs; };
  };

  programs.home-manager.enable = true;
}
