{ pkgs, ... }:
{
  enable = true;
  arguments = [
    "--hidden"
    "--follow"
    "--smart-case"
    "--max-columns=150"
    "--max-columns-preview"
    "--glob=!.git/*"
    "--colors=path:fg:green"
    "--colors=line:style:bold"
    "--colors=line:fg:blue"
  ];
}
