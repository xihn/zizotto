# zizotto
fork of ritotto hugo theme for the zola static site generator

{
  description = "A flake for developing with Zola in a Nix dev environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
    in {
      devShells.${system} = {
        default = nixpkgs.lib.mkShell {
          buildInputs = [
            nixpkgs.packages.${system}.zola,
            nixpkgs.packages.${system}.hut
          ];
        };
      };
    };
}
