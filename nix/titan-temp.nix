{ config, pkgs, ... }:

{
  topology.self.interfaces.enp3s0 = {
    addresses = ["192.168.1.77"];
    network = "home";
  };

  networking.hostName = "titan";
}
