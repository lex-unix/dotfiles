{ userConfig, pkgs, ... }:
{
  enable = true;
  config = {
    map-syntax = [
      "*.astro:TypeScriptReact"
      "*.mdx:Markdown"
    ];
    theme = if userConfig.theme == "light" then "GitHub" else "gruvbox";
    line-range = ":300";
    style = "numbers,grid,header";
  };

  themes = {
    gruvbox = {
      src = pkgs.fetchFromGitHub {
        owner = "molchalin";
        repo = "gruvbox-material-bat";
        rev = "843e67f926bbc4707256f6a8d0d8b819e5006bc1";
        hash = "sha256-J6UePv2qyZcvWa9IKv943i1w4bteWp2tjF9n2taYJog=";
      };
      file = "gruvbox-material-dark.tmTheme";
    };
  };
}
