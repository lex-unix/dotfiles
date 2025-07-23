{ userConfig, pkgs, ... }:
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

  userName = "Lex Miin";
  userEmail = "hello@lexunix.me";

  aliases = {
    a = "!git status --short | fzf --multi | awk '{print $2}' | xargs git add";
    ps = "!git push origin $(git rev-parse --abbrev-ref HEAD)";
    pl = "!git pull origin $(git rev-parse --abbrev-ref HEAD)";
    pr = "remote prune origin";
    co = "checkout";
    ci = "commit";
    st = "status";
    br = "branch";
    ba = "branch -a";
    bm = "branch --merged";
    bn = "branch --no-merged ";
    d = "diff";
    df = "!git hist | fzf | awk '{print $2}' | xargs -I {} git diff {}^ {}";
    hist = "log --pretty=format:\"%Cgreen%h %Creset%cd %Cblue[%cn] %Creset%s%C(yellow)%d%C(reset)\" --graph --date=relative --decorate --all";
    llog = "log --graph --name-status --pretty=format:\"%C(red)%h %C(reset)(%cd) %C(green)%an %Creset%s %C(yellow)%d%Creset\" --date=relative";
    type = "cat-file -t";
    dump = "cat-file -p";
  };

  extraConfig = {
    core = {
      editor = "nvim";
    };
    init = {
      defaultBranch = "main";
    };
    color = {
      status = "auto";
      diff = "auto";
      branch = "auto";
      interactive = "auto";
      grep = "auto";
      ui = "auto";
    };
    github = {
      user = "lex-unix";
    };
    delta = {
      features = userConfig.theme;
    };
    diff = {
      tool = "nvimdiff";
    };
    "difftool \"nvimdiff\"" = {
      cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
      path = "";
    };
    "mergetool \"nvimdiff\"" = {
      cmd = "nvim -d \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"";
      trustExitCode = true;
    };
  };

  ignores = [
    ".DS_Store"
    "*.sw[po]"
    "tags"
    "TAGS"
    "__pycache__"
    "*.o"
    "*.log"
    "tempCodeRunnerFile.*"
    "node_modules"
    "venv"
  ];

  delta = {
    enable = true;
    options = {
      dark = makeThemeConfig "dark";
      light = makeThemeConfig "light";
    };
  };
}
