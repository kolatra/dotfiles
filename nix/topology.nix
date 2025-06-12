{ config, ... }:

let
inherit (config.lib.topology) mkInternet mkRouter mkConnection;
in
{
  nodes.pandora = {
    deviceType = "device";
    hardware.info = "Fedora 42";
    interfaces.enp35s0.physicalConnections = [(mkConnection "router" "wlan")];
  };

  networks.home = {
    name = "Home Network";
    cidrv4 = "192.168.1.1/24";
  };

  nodes.internet = mkInternet {
    connections = [(mkConnection "router" "wlo1") (mkConnection "router" "wlan")];
  };

  nodes.router = mkRouter "tplink" {
    info = "TPLinkWifi";
    interfaceGroups = [["wlo1" "wlan"]];
    connections.wlan = [(mkConnection "titan" "enp3s0")];
    interfaces.wlan = {
      addresses = [ "192.168.1.83" ];
      network = "home";
      physicalConnections = [(mkConnection "router" "wlan")];
    };
    connections.wlo1 = [(mkConnection "router" "wlo1") (mkConnection "tethys" "wlo1")];
    interfaces.wlo1 = {
      addresses = [ "192.168.1.83" ];
      network = "home";
      physicalConnections = [ { node = "router"; interface = "wlo1"; } ];
    };
  };
}
