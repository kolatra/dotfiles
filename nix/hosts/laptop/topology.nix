{ config, pkgs, inputs, ... }:

{
  topology.self.interfaces.wlo1 = {
    addresses = ["192.168.1.75"];
    network = "home";
  };
}
