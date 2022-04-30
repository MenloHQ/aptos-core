{ lib
, rustPlatform
, pkgconfig
, openssl
, zlib
, postgresql
, python3
, nodejs
, sccache
, darwinPackages
}:

with rustPlatform;

buildRustPackage rec {
  pname = "aptos";
  version = "latest";

  src = ./.;

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "bytecode-interpreter-crypto-0.1.0" = "sha256-Q+Hl+E3PQiKvJhs/2RdBUc6AVBvQ9FkGVJbcT5Uz8H0=";
      "ed25519-dalek-1.0.1" = "sha256-jErvoSDtHJERwhks0nbjwgHkb8ukf5As7F+ALgqa/I0=";
      "serde-generate-0.20.6" = "sha256-lEgfzIR8tTVsQuECC2xh6ip4WgAEi8z5sY1776DzrlQ=";
    };
  };
  strictDeps = true;

  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ openssl zlib python3 nodejs postgresql sccache darwinPackages ];

  doCheck = false;

  meta = with lib; {
    description =
      "Aptos is building the safest and most scalable Layer 1 blockchain.";
    homepage = "https://aptoslabs.com";

    license = licenses.asl20;
  };
}
