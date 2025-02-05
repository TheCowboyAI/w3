{ pkgs, system, self }:

pkgs.nixosTest {
  name = "vm-test";
  nodes = {
    vm = { config, pkgs, ... }: {
      imports = [ self.packages.${system}.cimVM.config.system.build.toplevel ];
    };
  };
  testScript = ''
    vm.start()
    vm.wait_for_unit("multi-user.target")
    vm.succeed("echo VM is running")
  '';
}
