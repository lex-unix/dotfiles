{ pkgs, ... }:
{
  enable = true;
  enableFishIntegration = true;
  settings = {
    add_newline = true;
    username = {
      show_always = true;
    };
    golang = {
      symbol = " ";
      style = "bold blue";
    };
    package = {
      disabled = true;
    };
    docker_context = {
      disabled = true;
    };
    nix_shell = {
      format = "via [$symbol]($style)";
      symbol = " ";
    };
  };
}
