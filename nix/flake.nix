{
  description = "Darwin and NixOS system configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    jj-starship.url = "github:dmmulroy/jj-starship";
    codex-cli-nix.url = "github:sadjow/codex-cli-nix";
    hunk.url = "github:modem-dev/hunk";
    fnox-nix.url = "github:lexmiin/fnox-nix";
  };

  outputs = inputs @ {
    nix-darwin,
    nixpkgs,
    ...
  }: let
    username = "lex";
    theme = "dark";

    overlays = [
      inputs.jj-starship.overlays.default
      inputs.codex-cli-nix.overlays.default
      inputs.fnox-nix.overlays.default
      (final: _prev: {
        hunk = inputs.hunk.packages.${final.stdenv.hostPlatform.system}.hunk;
      })
      (import ./overlays/pitchfork.nix)
    ];

    mkSystem = import ./lib/mksystem.nix {
      inherit nixpkgs overlays inputs;
    };
  in {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.aarch64-linux = nixpkgs.legacyPackages.aarch64-linux.alejandra;

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
