{ pkgs, ... }:
with pkgs; [
  just
  nix
  bash
  zsh

  # Nix        
  nix-index
  nixpkgs-fmt
  nixd
  alejandra

  # Rust
  bacon

  # cargo
  cargo
  cargo-edit
  cargo-expand
  cargo-udeps
  cargo-whatfeatures
  cargo-generate
  cargo-make
  cargo-edit

  # wasm
  wasmtime
  wasmserve
  wasm-tools
  wasm-pack
  alsa-lib
]
