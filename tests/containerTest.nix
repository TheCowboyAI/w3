{ pkgs, system, self, ... }:

pkgs.nixosTest {
  name = "container-test";
  machineConfig =
    self.nixosConfigurations.container.config.system.build.toplevel;
  testScript =
    ''
      machine.start()
      machine.wait_for_unit("multi-user.target")
      machine.succeed("echo Container is running")
    '';
}
