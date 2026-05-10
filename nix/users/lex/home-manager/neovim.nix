{ pkgs, inputs, ... }:
let
  pkgsNeovim = import inputs.nixpkgs-neovim {
    system = pkgs.stdenv.hostPlatform.system;
    config.allowUnfree = true;
  };
  neovimPkg = pkgsNeovim.neovim-unwrapped;
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withRuby = false;
    package =
      assert builtins.match "0\\.11\\..*" neovimPkg.version != null;
      neovimPkg;
  };
}
