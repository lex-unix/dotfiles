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
        owner = "Colorsublime";
        repo = "Colorsublime-Themes";
        rev = "56b1b09c4d63c61a9fbfdd4eeb517c023497b64c";
        hash = "sha256-99uKbWJF5iJ/EkRiSCbtl2DZUwgYmrZQuCPhzo1HBgg=";
      };
      file = "themes/Chelevra-Ayu.tmTheme";
    };
  };
}