{ userConfig, pkgs, ... }:
{
  enable = true;

  settings = {
    user.name = "Lex Miin";
    user.email = "hello@lexunix.me";
    alias = {
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
}
