# Usage
Things I expect to work:
- `nix build`
  - build the package in Cargo.toml
  - all I have to change is Cargo.toml and builds still function normally
  - I can extend the buildPackage sequence
  - I can adapt my ci/cd pipeline
  - I can emit an Event when a build happens
  - I can emit an Event when the build fails
- `nix run`
  - the package runs    ***WE ARE HERE ***
  - I can add packages
  - I can add services
  - I can add modules
  - It can emit Events
  - It can run it in a container
  - It can run it in a VM
  - It can run it on metal
  - It can have a web interface
  - It can talk to nats locally
  - It can have the local nats server join another nats server
  - It can subscribe to Subjects
  - It can Publish to Subjects
  - It can issue Request/Response
  - The package has it's own Subject
  - It can be monitored
  - It can be controlled

  That's quite a few things that need to happen here and the Flake controls it all.

  We are going to add and create several modules to make this happen by following our own instructions.

  We simply start the UI.

  Whatever you need above, we can enable or disable easily.

