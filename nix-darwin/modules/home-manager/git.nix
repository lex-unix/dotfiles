{ pkgs, ... }:
{
  enable = true;

  userName = "Lex Miin";
  userEmail = "alexmiyin@gmail.com";

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
      features = "mellow";
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
    ghq = {
      root = "~/.ghq";
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
      gruvbox-material = {
        dark = true;
        syntax-theme = "base16";
        line-numbers = true;
        side-by-side = true;
        file-style = "brightwhite";
        file-decoration-style = "none";
        file-added-label = "[+]";
        file-copied-label = "[==]";
        file-modified-label = "[*]";
        file-removed-label = "[-]";
        file-renamed-label = "[->]";
        hunk-header-decoration-style = "#3c3836 box ul";
        plus-style = "brightgreen #2e3b3b";
        plus-emph-style = "#32361a green";
        minus-style = "brightred #2e3b3b";
        minus-emph-style = "#3c1f1e red";
        line-numbers-minus-style = "brightred";
        line-numbers-plus-style = "brightgreen";
        line-numbers-left-style = "#3c3836";
        line-numbers-right-style = "#3c3836";
        line-numbers-zero-style = "#504945";
        zero-style = "syntax";
        whitespace-error-style = "black bold";
        blame-code-style = "syntax";
        blame-palette = "#141617 #1d2021 #282828 #3c3836";
        merge-conflict-begin-symbol = "~";
        merge-conflict-end-symbol = "~";
        merge-conflict-ours-diff-header-style = "yellow bold";
        merge-conflict-ours-diff-header-decoration-style = "#3c3836 box";
        merge-conflict-theirs-diff-header-style = "yellow bold";
        merge-conflict-theirs-diff-header-decoration-style = "#3c3836 box";
      };
      mellow = {
        dark = true;
        syntax-theme = "base16";
        line-numbers = true;
        side-by-side = true;
        file-style = "brightwhite";
        file-decoration-style = "none";
        file-added-label = "[+]";
        file-copied-label = "[==]";
        file-modified-label = "[*]";
        file-removed-label = "[-]";
        file-renamed-label = "[->]";
        hunk-header-decoration-style = "'#3c3836' box ul";
        plus-style = "brightgreen black";
        plus-emph-style = "black green";
        minus-style = "brightred black";
        minus-emph-style = "black red";
        line-numbers-minus-style = "brightred";
        line-numbers-plus-style = "brightgreen";
        line-numbers-left-style = "'#3c3836'";
        line-numbers-right-style = "'#3c3836'";
        line-numbers-zero-style = "'#504945'";
        zero-style = "syntax";
        whitespace-error-style = "black bold";
        blame-code-style = "syntax";
        blame-palette = "'#141617' '#1d2021' '#282828' '#3c3836'";
        merge-conflict-begin-symbol = "~";
        merge-conflict-end-symbol = "~";
        merge-conflict-ours-diff-header-style = "yellow bold";
        merge-conflict-ours-diff-header-decoration-style = "'#3c3836' box";
        merge-conflict-theirs-diff-header-style = "yellow bold";
        merge-conflict-theirs-diff-header-decoration-style = "'#3c3836' box";
      };
    };
  };
}
