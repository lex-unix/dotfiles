{ pkgs, ... }:
{
  # Don't touch this, Home Manager can be updated without changing this value
  home.stateVersion = "24.11";

  home.username = "lex";
  home.homeDirectory = "/Users/lex";

  home.packages = with pkgs; [
    tmux
    jq
    fd
    ripgrep
    fzf
    bat
    btop
    eza
    zoxide
    wget
    coreutils
    jankyborders
  ];

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = true;
      username = {
        show_always = true;
      };
      golang = {
        symbol = " ";
        style = "bold blue";
      };
      package = {
        disabled = true;
      };
      docker_context = {
        disabled = true;
      };
    };
  };

  programs.home-manager.enable = true;
}
