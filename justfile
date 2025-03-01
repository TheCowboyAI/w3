default:
    @just --list

# Run 'cargo run' on the project
run *ARGS:
    nix run {{ARGS}}

watch *ARGS:
	bacon watch -- -- {{ ARGS }}

start: 
    nix run

build:
    nix build

run-bin:
  result/bin/cim

cn-make:
  sudo nixos-container create cimc --flake .#cimc
cn-start:
  sudo nixos-container start cimc
cn-stop:
  sudo nixos-container stop cimc
cn-destroy:
  sudo nixos-container destroy cimc
cn-run:
  sudo nixos-container login cimc
