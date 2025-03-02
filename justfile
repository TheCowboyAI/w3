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
  sudo nixos-container create cimc --flake .#cimc --config ' \
  { config, ... }: {                                                      \
    containers.cimc = {\
      bindMounts."/run/user/1000/wayland-1" = {\
        hostPath = "/run/user/1000/wayland-1";\
        isReadOnly = false;\
      };\
      \
      allowedDevices = [\
        {\
          node = "/dev/dri";\
          modifier = "rwm";\
        }\
      ];\
    };\
  }'

cn-start:
  sudo nixos-container start cimc
cn-stop:
  sudo nixos-container stop cimc
cn-destroy:
  sudo nixos-container destroy cimc
cn-run:
  sudo nixos-container login cimc
