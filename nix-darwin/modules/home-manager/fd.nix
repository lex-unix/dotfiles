{ pkgs, ... }:
{
  enable = true;
  extraOptions = [
    "--hidden"
  ];
  ignores = [
    "node_modules"
    "target"
    "venv"
    ".venv"
    ".git"
  ];
}
