{ userConfig, pkgs, ... }:
{
  enable = true;
  config = {
    map-syntax = [
      "*.astro:TypeScriptReact"
      "*.mdx:Markdown"
    ];
    theme = userConfig.theme;
    line-range = ":300";
    style = "numbers,grid,header";
  };

  themes = {
    mellow = {
      src = pkgs.fetchFromGitHub {
        owner = "mellow-theme";
        repo = "mellow.nvim";
        rev = "434a02d5f7637a24824569426176f37473205053";
        hash = "sha256-Lr4+KxQRsTJrqwGtRMcxBwDZq84v6Pl4NUcfu+5XhRs=";
      };
      file = "extras/bat/mellow.tmTheme";
    };
    gruvbox = {
      src = pkgs.fetchFromGitHub {
        owner = "molchalin";
        repo = "gruvbox-material-bat";
        rev = "843e67f926bbc4707256f6a8d0d8b819e5006bc1";
        hash = "sha256-J6UePv2qyZcvWa9IKv943i1w4bteWp2tjF9n2taYJog=";
      };
      file = "gruvbox-material-dark.tmTheme";
    };
    ayu = {
      src = pkgs.fetchFromGitHub {
        owner = "CheDESIGNER";
        repo = "ayu";
        rev = "ef6aa09bb76e694a39f3a9bd8b49691efaecc860";
        hash = "sha256-kp1IfW4d7RNxJ3nrvIWrovTHNgiyot4s8gF/kOX7U5U=";
      };
      file = "ayu.tmTheme";
    };
    tokyonight = {
      src = pkgs.fetchFromGitHub {
        owner = "folke";
        repo = "tokyonight.nvim";
        rev = "b262293ef481b0d1f7a14c708ea7ca649672e200";
        hash = "sha256-pMzk1gRQFA76BCnIEGBRjJ0bQ4YOf3qecaU6Fl/nqLE=";
      };
      file = "extras/sublime/tokyonight_night.tmTheme";
    };
  };
}
