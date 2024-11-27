{ pkgs, ... }:
{
  enable = true;
  enableFishIntegration = true;
  enableZshIntegration = true;

  defaultCommand = "${pkgs.fd}/bin/fd --type d --search-path $HOME/dev --exclude .git --exclude venv --exclude '**/target' --exclude node_modules";
}
