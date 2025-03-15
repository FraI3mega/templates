{
  description = "A devShell example";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    rust-overlay,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        overlays = [(import rust-overlay)];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
      in {
        devShells.default = with pkgs;
          mkShell {
            nativeBuildInputs = with pkgs; [
              pkg-config
              openssl
            ];

            buildInputs = [
              (rust-bin.stable.latest.default.override {extensions = ["rust-analyzer"];})
              fd
              # development utilities
              bacon
              cargo-dist
              cargo-nextest
              cargo-deny
            ];

            shellHook = ''
              alias find=fd
            '';

            env = {};
          };
      }
    );
}
