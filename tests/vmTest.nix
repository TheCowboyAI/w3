{ pkgs, system, self, ... }:

pkgs.nixosTest {
  name = "vm-test";
  machineConfig =
    self.packages.${system}.cimVM.config.system.build.toplevel;
  testScript =
    ''
      machine.start()
      machine.wait_for_unit("multi-user.target")
      machine.succeed("echo VM is running")
    '';
}
