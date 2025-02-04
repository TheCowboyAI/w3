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

docker-build-image:

docker-load:
  docker load < result

docker-tag-latest:
  docker tag cim:latest thecowboyai/cim-start:latest

docker-load-new:
  just docker-build-image
  just docker-load
  just docker-tag-latest

docker-push:
  docker push thecowboyai/cim-start:latest

docker-run:
  docker run --rm \
  -it \
  -e XDG_RUNTIME_DIR=/run/user/1000 \
  -e WAYLAND_DISPLAY=wayland-1 \
  -e QT_QPA_PLATFORM=wayland \
  -e GDK_BACKEND=wayland \
  -v $(pwd)/src:/src \
  -v /run/user/1000/wayland-1:/run/user/1000/wayland-1 \
  thecowboyai/cim-start:latest 

make-nixos:
  sudo nixos-container stop cim
  sudo nixos-container destroy cim
  sudo nixos-container create cim --config-file ./modules/configuration.nix

run-nixos:
  sudo nixos-container start cim
  sudo nixos-container root-login cim
