{...}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "hello@lexunix.me";
        name = "Lex Miin";
      };
      aliases = {
        tug = [
          "bookmark"
          "move"
          "--from"
          "closest_bookmark(@-)"
          "--to"
          "@-"
        ];
        d = ["diff"];
        retrunk = ["rebase" "--onto" "trunk()"];
      };
      revset-aliases = {
        "closest_bookmark(to)" = "heads(::to & bookmarks())";
        "today_mine()" = "mine() & author_date(after:\"yesterday 23:59\")";
      };
      ui = {
        default-command = "log";
        pager = [
          "hunk"
          "pager"
        ];
        diff-formatter = ":git";
        diff-instructions = false;
        diff-editor = [
          "nvim"
          "-c"
          "DiffEditor $left $right $output"
        ];
      };
    };
  };
}
