{
  description = "Darwin and NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-neovim.url = "github:NixOS/nixpkgs/nixos-25.05";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    jj-starship.url = "github:dmmulroy/jj-starship";
  };

  outputs =
    inputs@{
      nix-darwin,
      nixpkgs,
      ...
    }:
    let
      username = "lex";
      theme = "dark";

      overlays = [
        inputs.jj-starship.overlays.default
      ];

      mkSystem = import ./lib/mksystem.nix {
        inherit nixpkgs overlays inputs;
      };
    in
    {
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt;
      formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.nixfmt;

      darwinConfigurations.macbook-pro-m1 = mkSystem "macbook-pro-m1" {
        inherit theme;
        system = "aarch64-darwin";
        user = username;
        darwin = true;
      };

      nixosConfigurations.vm-aarch64 = mkSystem "vm-aarch64" {
        inherit theme;
        system = "aarch64-linux";
        user = username;
      };
    };
}
