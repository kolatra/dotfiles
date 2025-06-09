{ config, pkgs, ... } :

{
  users.users = {
    tyler = {
      isNormalUser = true;
      initialPassword = "correcthorse";
      description = "tyler";
      shell = pkgs.zsh;
      home = "/home/tyler";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      openssh.authorizedKeys.keys = [  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEdQDJEnAKSK5MECKcpzcNFgPSs0BnHwCi53U88YTFN tyler" ];
    };
  };
}
