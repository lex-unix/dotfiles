{
  pkgs,
  currentSystemUser,
  ...
}:
{
  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  programs.fish.enable = true;

  users.users.${currentSystemUser} = {
    isNormalUser = true;
    home = "/home/${currentSystemUser}";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    hashedPassword = "$6$NJCdi9SrCRnoWnpR$ub4tttotBZj6W.qnbIcro8JeKRLH3le0tpJXCeeKGEe4QHgvtOAeIhM2EP5H5sqMJqKaXFsZ.rlRceZbxi27..";
    shell = pkgs.fish;
  };
}
