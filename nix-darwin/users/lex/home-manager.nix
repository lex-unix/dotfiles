{
  currentSystemName,
  currentSystemUser,
  currentTheme,
  inputs,
  ...
}:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  homeDirectory =
    if pkgs.stdenv.isDarwin then "/Users/${currentSystemUser}" else "/home/${currentSystemUser}";

  dotfilesPath = "${homeDirectory}/dotfiles";

  inherit (config.lib.file) mkOutOfStoreSymlink;
in
{
  # Don't touch this, Home Manager can be updated without changing this value
  home.stateVersion = "24.11";

  home.username = currentSystemUser;
  home.homeDirectory = homeDirectory;

  home.shell.enableShellIntegration = true;
  home.shell.enableNushellIntegration = true;

  home.sessionVariables = {
    PAGER = "less -FirSwX";
  };

  home.packages =
    with pkgs;
    [
      jq
      gh
      kubectl
      zig
      eza
      wget
      coreutils
      awscli2
      _1password-cli
      tldr
      uv
      just
      hyperfine
      bun
      nodejs
      elixir
      openssl
      jj-starship
    ]
    ++ lib.optionals isDarwin [
      jankyborders
      gnused
    ]
    ++ lib.optionals isLinux [
      firefox
      ghostty
    ];

  imports = [
    ./home-manager/starship.nix
    ./home-manager/bat.nix
    ./home-manager/fish.nix
    ./home-manager/zoxide.nix
    ./home-manager/kitty.nix
    ./home-manager/tmux.nix
    ./home-manager/fzf.nix
    ./home-manager/git.nix
    ./home-manager/ripgrep.nix
    ./home-manager/fd.nix
    ./home-manager/neovim.nix
    ./home-manager/go.nix
    ./home-manager/direnv.nix
    ./home-manager/jujutsu.nix
    ./home-manager/yazi.nix
    ./home-manager/btop.nix
    ./home-manager/delta.nix
    ./home-manager/nushell.nix
  ];

  xdg = {
    enable = true;
    localBinInPath = true;
    configFile.nvim.source = mkOutOfStoreSymlink "${dotfilesPath}/nvim";
    configFile."nvim/init.lua".enable = lib.mkForce false;
    configFile.ghostty.source = mkOutOfStoreSymlink "${dotfilesPath}/ghostty";
    configFile."karabiner/karabiner.json" = lib.mkIf pkgs.stdenv.isDarwin {
      source = mkOutOfStoreSymlink "${dotfilesPath}/karabiner/karabiner.json";
    };
  };

  _module.args = {
    inherit
      currentSystemName
      currentSystemUser
      currentTheme
      inputs
      isDarwin
      isLinux
      ;
  };

  programs.home-manager.enable = true;
}
