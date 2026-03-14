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
      disabled = true;
    };
    git_branch = {
      disabled = true;
    };
    git_status = {
      disabled = true;
    };
    git_commit = {
      disabled = true;
    };
    custom = {
      jj = {
        when = "jj-starship detect";
        format = "$output ";
        shell = [
          "jj-starship"
          "--no-git-id"
        ];
      };
    };
  };
}
