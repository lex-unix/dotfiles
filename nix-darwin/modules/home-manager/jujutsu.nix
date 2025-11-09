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
    ui = {
      default-command = "log";
    };
  };
}
