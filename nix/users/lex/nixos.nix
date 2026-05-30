{
  pkgs,
  currentSystemUser,
  ...
}: {
  # Add ~/.local/bin to PATH
  environment.localBinInPath = true;

  programs.fish.enable = true;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
  ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [currentSystemUser];
  };

  systemd.user.services.swaybg = {
    description = "Wallpaper for Wayland";
    wantedBy = ["niri.service"];
    partOf = ["graphical-session.target"];
    after = ["graphical-session.target"];
    requisite = ["graphical-session.target"];

    serviceConfig = {
      ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i %h/Pictures/wallpaper.png";
      Restart = "on-failure";
    };
  };

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
