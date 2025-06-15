{ config, pkgs, inputs, ... }:

{
  imports = [
      inputs.nix-topology.nixosModules.default
  ];

  topology.self.interfaces.wlo1 = {
    addresses = ["192.168.1.75"];
    network = "home";
  };
}
