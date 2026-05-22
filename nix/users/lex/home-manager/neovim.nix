{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withPython3 = true;
    withRuby = false;
    sideloadInitLua = true;
    extraPackages = [pkgs.tree-sitter pkgs.ast-grep];
  };
}
