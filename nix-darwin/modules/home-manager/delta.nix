{ userConfig, ... }:
let
  baseDeltaConfig = {
    dark = userConfig.theme == "dark";
    line-numbers = true;
    side-by-side = false;
    file-style = "brightwhite";
    file-decoration-style = "none";
    file-added-label = "[+]";
    file-copied-label = "[==]";
    file-modified-label = "[*]";
    file-removed-label = "[-]";
    file-renamed-label = "[->]";
    zero-style = "syntax";
    blame-code-style = "syntax";
    merge-conflict-begin-symbol = "~";
    merge-conflict-end-symbol = "~";
  };

  # Theme-specific configurations
  themeConfigs = {
    dark = {
      syntax-theme = "gruvbox";
      plus-style = "syntax #323619";
      plus-emph-style = "white #4C531F";
      minus-style = "syntax #3C1F1E";
      minus-emph-style = "white #672A28";
      line-numbers-minus-style = "brightred";
      line-numbers-plus-style = "brightgreen";
    };

    light = {
      syntax-theme = "GitHub";
      hunk-header-decoration-style = "#3c3836 box ul";
      plus-style = "syntax #DAFBE1";
      plus-emph-style = "syntax #ACEEBB";
      minus-style = "syntax #FEEBE9";
      minus-emph-style = "syntax #FFCECB";
    };

  };

  makeThemeConfig = theme: baseDeltaConfig // themeConfigs.${theme};
in
{
  enable = true;
  options = {
    dark = makeThemeConfig "dark";
    light = makeThemeConfig "light";
  };
  enableGitIntegration = true;
  enableJujutsuIntegration = true;
}
