{ pkgs, ... }:
{
  enable = true;
  settings = {
    user = {
      email = "hello@lexunix.me";
      name = "Lex Miin";
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
