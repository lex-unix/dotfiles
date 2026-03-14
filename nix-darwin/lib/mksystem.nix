{
  nixpkgs,
  overlays,
  inputs,
}:
name:
{
  system,
  user,
  theme ? "dark",
  darwin ? false,
}:
let
  isDarwin = darwin;
  isLinux = !isDarwin;

  machineConfig = ../machines/${name}.nix;
  userOSConfig = ../users/${user}/${if isDarwin then "darwin" else "nixos"}.nix;
  userHMConfig = ../users/${user}/home-manager.nix;
  systemFunc = if isDarwin then inputs.nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
  home-manager =
    if isDarwin then
      inputs.home-manager.darwinModules.home-manager
    else
      inputs.home-manager.nixosModules.home-manager;

  inherit (nixpkgs.lib) optionals;
in
systemFunc {
  inherit system;
  modules = [
    { nixpkgs.overlays = overlays; }
    { nixpkgs.config.allowUnfree = true; }
    machineConfig
    userOSConfig
    home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = import userHMConfig {
          inherit inputs;
          currentSystemName = name;
          currentSystemUser = user;
          currentTheme = theme;
        };
        backupFileExtension = "before-nix";
      };
    }
  ]
  ++ optionals isDarwin [
    inputs.nix-homebrew.darwinModules.nix-homebrew
    {
      nix-homebrew = {
        enable = true;
        enableRosetta = true;
        user = user;
        autoMigrate = true;
      };
    }
  ]
  ++ [
    {
      config._module.args = {
        inherit inputs;
        currentSystem = system;
        currentSystemName = name;
        currentSystemUser = user;
        currentTheme = theme;
        inherit isDarwin isLinux;
      };
    }
  ];
}
