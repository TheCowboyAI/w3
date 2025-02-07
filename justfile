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

vm-build:
  nixos-rebuild build-vm --flake .#cim-microvm

vm-run:
  ./result/bin/run-cim-microvm-vm

cn-make:
  sudo nixos-container create cim --config-file ./modules/configuration.nix
cn-stop:
  sudo nixos-container stop cim
cn-destroy:
  sudo nixos-container destroy cim
cn-run:
  sudo nixos-container start cim
  sudo nixos-container root-login cim
