{ pkgsNeovim, ... }:
let
  neovimPackage = pkgsNeovim.neovim-unwrapped;
in
{
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;
  withPython3 = true;
  withRuby = false;
  package =
    assert builtins.match "0\\.11\\..*" neovimPackage.version != null;
    neovimPackage;
}
