{ config, pkgs, inputs, ...}:

let 
  jre21 = pkgs.temurin-bin-21;
in {
  imports = [ inputs.mms.module ];

  services.modded-minecraft-servers = {
    eula = true;

    instances = {
      gtnh = {
        enable = true;
        jvmMaxAllocation = "8G";
        jvmInitialAllocation = "8G";
        jvmPackage = jre21;

        rsyncSSHKeys = ["qwerty"]; # workaround for mkaito/nixos-modded-minecraft-servers/issues/6

        serverConfig = {
            server-port = 25565;
            motd = "GregTech: New Horizons 2.7.4";
            white-list = true;
            spawn-protection = 0;
            max-tick-time = 5 * 60 * 1000;
            allow-flight = true;
            view-distance = 16;
        };
      };

      monifactory = {
        enable = false;
        jvmMaxAllocation = "8G";
        jvmInitialAllocation = "8G";
        jvmPackage = jre21;

        rsyncSSHKeys = ["qwerty"]; # workaround for mkaito/nixos-modded-minecraft-servers/issues/6

        serverConfig = {
            server-port = 25565;
            motd = "Monifactory";
            white-list = true;
            spawn-protection = 0;
            max-tick-time = 5 * 60 * 1000;
            allow-flight = true;
        };
      };
    };
  };
}
