{
  config,
  pkgs,
  userConfig,
  ...
}:
let
  inherit (config.lib.file) mkOutOfStoreSymlink;
  dotfilesPath = "/Users/${userConfig.username}/dotfiles";
in
{
  # Don't touch this, Home Manager can be updated without changing this value
  home.stateVersion = "24.11";

  home.username = userConfig.username;
  home.homeDirectory = "/Users/${userConfig.username}";

  home.packages = with pkgs; [
    jq
    gh
    kubectl
    zig
    btop
    eza
    wget
    coreutils
    jankyborders
    awscli2
    _1password-cli
    ffmpeg
    tldr
    uv
  ];

  xdg = {
    enable = true;
    configFile.nvim.source = mkOutOfStoreSymlink "${dotfilesPath}/nvim";
    configFile.ghostty.source = mkOutOfStoreSymlink "${dotfilesPath}/ghostty";
    configFile."karabiner/karabiner.json".source =
      mkOutOfStoreSymlink "${dotfilesPath}/karabiner/karabiner.json";
  };

  programs = {
    starship = import ./starship.nix { inherit pkgs; };
    bat = import ./bat.nix { inherit pkgs userConfig; };
    fish = import ./fish.nix { inherit pkgs; };
    zoxide = import ./zoxide.nix { inherit pkgs; };
    kitty = import ./kitty.nix { inherit pkgs userConfig; };
    tmux = import ./tmux.nix { inherit pkgs; };
    fzf = import ./fzf.nix { inherit pkgs; };
    git = import ./git.nix { inherit pkgs userConfig; };
    ripgrep = import ./ripgrep.nix { inherit pkgs; };
    fd = import ./fd.nix { inherit pkgs; };
    neovim = import ./neovim.nix { inherit pkgs; };
    go = import ./go.nix { inherit pkgs; };
    direnv = import ./direnv.nix { inherit pkgs; };
  };

  programs.home-manager.enable = true;
}
