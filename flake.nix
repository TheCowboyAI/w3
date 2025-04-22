{
  description = "W3 Project with Crystalline Neon design system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, rust-overlay, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        
        rustToolchain = pkgs.rust-bin.stable.latest.default.override {
          extensions = [ "rust-src" "rust-analyzer" "clippy" ];
          targets = [ "wasm32-unknown-unknown" ];
        };

        nativeBuildInputs = with pkgs; [
          rustToolchain
          trunk
          wasm-bindgen-cli
          wasm-pack
          binaryen # For wasm-opt
          nodePackages.tailwindcss
          nodePackages.postcss
          nodePackages.autoprefixer
        ];

      in
      {
        devShells.default = pkgs.mkShell {
          inherit nativeBuildInputs;
          
          RUST_SRC_PATH = "${rustToolchain}/lib/rustlib/src/rust/library";
          
          shellHook = ''
            echo "W3 Development Environment"
            echo "Rust: $(rustc --version)"
            echo "Node: $(node --version)"
            echo "Tailwind CSS: $(tailwindcss --version)"
            echo ""
            echo "Available commands:"
            echo "  trunk serve     - Start development server"
            echo "  trunk build     - Build for production"
            echo ""
          '';
        };
      }
    );
} 