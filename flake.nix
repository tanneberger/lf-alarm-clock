{
  description = "build script for the lingua-franca alarm clock";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    reactor-cpp.url = "github:lf-lang/reactor-cpp";
  };

  outputs = inputs@{ self, utils, nixpkgs, reactor-cpp, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        checks = packages;
        packages.lf-alarm-clock = nixpkgs.legacyPackages.${system}.callPackage ./nix/derivation.nix { 
          reactor-cpp = reactor-cpp.packages."${system}".reactor-cpp;
        };
        packages.default = nixpkgs.legacyPackages.${system}.callPackage ./nix/derivation.nix { 
          reactor-cpp = reactor-cpp.packages."${system}".reactor-cpp;
        };
        nixosModules.default = { 
          imports  = [./nix/module.nix ]; 
        };
      }
    );
}
