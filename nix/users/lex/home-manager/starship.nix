{pkgs, ...}: {
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
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
          when = "${pkgs.jj-starship}/bin/jj-starship detect";
          format = "$output ";
          shell = [
            "${pkgs.jj-starship}/bin/jj-starship"
            "--no-git-id"
          ];
        };
      };
    };
  };
}
