{
  lib,
  pkgs,
  ...
}: {
  home.packages = [pkgs.fnox];

  programs.fish.interactiveShellInit = ''
    ${lib.getExe pkgs.fnox} activate fish | source
  '';

  programs.zsh.initContent = lib.mkOrder 851 ''
    eval "$(${lib.getExe pkgs.fnox} activate zsh)"
  '';

  programs.nushell.extraConfig = ''
    source ${
      pkgs.runCommand "fnox-nushell-config.nu" {} ''
        ${lib.getExe pkgs.fnox} activate nu > "$out"
      ''
    }
  '';
}
