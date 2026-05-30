{
  currentSystemName,
  currentSystemUser,
  currentTheme,
  inputs,
  ...
}: {
  config,
  lib,
  pkgs,
  ...
}: let
  isDarwin = pkgs.stdenv.isDarwin;
  isLinux = pkgs.stdenv.isLinux;

  homeDirectory =
    if pkgs.stdenv.isDarwin
    then "/Users/${currentSystemUser}"
    else "/home/${currentSystemUser}";

  dotfilesPath = "${homeDirectory}/dotfiles";

  inherit (config.lib.file) mkOutOfStoreSymlink;
in {
  # Don't touch this, Home Manager can be updated without changing this value
  home.stateVersion = "24.11";

  home.username = currentSystemUser;
  home.homeDirectory = homeDirectory;

  home.shell.enableShellIntegration = true;
  home.shell.enableNushellIntegration = true;

  home.pointerCursor = lib.mkIf isLinux {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };

  home.sessionVariables =
    {
      PAGER = "less -FirSwX";
      LEX_THEME = currentTheme;
    }
    // lib.optionalAttrs isLinux {
      XCURSOR_SIZE = "24";
      XCURSOR_THEME = "Adwaita";
    };

  home.shellAliases = {
    g = "git";
    c = "clear";
    q = "exit";
    j = "jj";
    h = "hunk";
    cat = "bat";
    ll = "eza -l -g --icons";
    lla = "ll -a";
    ".." = "cd ..";
    oc = "opencode attach --dir . http://0.0.0.0:4096";
  };

  home.packages = with pkgs;
    [
      jq
      kubectl
      eza
      wget
      coreutils
      awscli2
      tldr
      uv
      just
      hyperfine
      bun
      nodejs
      elixir
      jj-starship
      hunk
      pitchfork
      codex
      mergiraf
      rustup
    ]
    ++ lib.optionals isDarwin [
      _1password-cli
      jankyborders
      gnused
    ]
    ++ lib.optionals isLinux [
      firefox
      ghostty
      swaybg
    ];

  imports = [
    ./home-manager/starship.nix
    ./home-manager/bat.nix
    ./home-manager/fish.nix
    ./home-manager/fnox.nix
    ./home-manager/zoxide.nix
    ./home-manager/kitty.nix
    ./home-manager/tmux.nix
    ./home-manager/fzf.nix
    ./home-manager/gh.nix
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
    ./home-manager/fuzzel.nix
    ./home-manager/waybar.nix
    ./home-manager/mako.nix
    ./home-manager/polkit.nix
    ./home-manager/swaylock.nix
    ./home-manager/swayidle.nix
  ];

  xdg = {
    enable = true;
    localBinInPath = true;
    configFile.nvim.source = mkOutOfStoreSymlink "${dotfilesPath}/nvim";
    configFile.niri = lib.mkIf isLinux {
      source = mkOutOfStoreSymlink "${dotfilesPath}/niri";
    };
    configFile.ghostty = {
      source = ../../../ghostty;
      recursive = true;
    };
    configFile."ghostty/linux/config" = lib.mkIf isLinux {
      text = ''
        font-size = 12
        keybind = performable:ctrl+c=copy_to_clipboard
        keybind = performable:ctrl+v=paste_from_clipboard
      '';
    };
    configFile."karabiner/karabiner.json" = lib.mkIf isDarwin {
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
