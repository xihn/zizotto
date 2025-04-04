{
  description = "A flake for developing with Zola in a Nix dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux"; # Adjust for your system, e.g., "aarch64-darwin" for Mac ARM
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.zola
          pkgs.hut
          pkgs.fish
        ];

        # Optional: Set environment variables here
        shellHook = ''
          echo "Loaded Zola development environment!"
          export IN_NIX_SHELL=1
          exec ${pkgs.fish}/bin/fish
        '';
      };
    };
}
