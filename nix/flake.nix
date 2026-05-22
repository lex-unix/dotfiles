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
    codex-cli-nix = {
      url = "github:sadjow/codex-cli-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hunk = {
      url = "github:modem-dev/hunk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
        inputs.codex-cli-nix.overlays.default
        (final: _prev: {
          hunk = inputs.hunk.packages.${final.stdenv.hostPlatform.system}.hunk;
        })
        (import ./overlays/pitchfork.nix)
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
