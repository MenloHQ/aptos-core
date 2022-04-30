{
  description = "Aptos Nix flake.";
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:

    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        aptos = pkgs.callPackage ./default.nix {
          inherit (pkgs) lib rustPlatform pkgconfig openssl zlib postgresql python3 nodejs sccache;
          darwinPackages =
            with pkgs; lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [ AppKit IOKit Foundation ]);
        };
      in
      {
        packages = { inherit aptos; };
        defaultPackage = aptos;
        devShell = pkgs.stdenvNoCC.mkDerivation {
          name = "devshell";
          inherit (aptos) buildInputs nativeBuildInputs;
        };
      });
}
