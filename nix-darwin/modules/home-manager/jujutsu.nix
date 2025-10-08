{ pkgs, ... }:
{
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
      d = [ "diff" ];
    };
    revset-aliases = {
      "closest_bookmark(to)" = "heads(::to & bookmarks())";
    };
    diff = {
      tool = "delta";
    };
    ui = {
      default-command = "log";
      pager = "delta";
      diff-formatter = ":git";
    };
    "--scope" = [
      {
        "--when.commands" = [
          "diff"
          "show"
        ];
        ui = {
          pager = "delta";
        };
      }
    ];
  };
}
