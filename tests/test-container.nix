{ pkgs, system, self }:

pkgs.nixosTest {
  name = "container-test";
  nodes = {
    container = { config, pkgs, ... }: {
      imports = [ self.nixosConfigurations.container ];
    };
  };
  testScript = ''
    container.start()
    container.wait_for_unit("multi-user.target")
    container.succeed("echo Container is running")
  '';
}
