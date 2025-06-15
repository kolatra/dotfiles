{ config, pkgs, ... } :

{
  users.users = {
    tyler = {
      isNormalUser = true;
      # initialPassword = "correcthorse";
      initialHashedPassword = "$y$j9T$gtz/rf/dNkrKfFXBaH0T3.$MnY8i2nw6HzsNB9LelwYiJXDPO/2fPl/RB1DiIEsbk1";
      description = "tyler";
      shell = pkgs.zsh;
      home = "/home/tyler";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      openssh.authorizedKeys.keys = [  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEdQDJEnAKSK5MECKcpzcNFgPSs0BnHwCi53U88YTFN tyler" ];
    };

    minecraft = {
      isNormalUser = true;
      initialHashedPassword = "$y$j9T$VyTefFymkOHpALv2dxvf0/$5lm4PYXTn7IoeKDAtR9y/5Ahyv3N0q/SaD7Z/8EkJu.";
      description = "Minecraft Server Runner";
      home = "/home/minecraft";
      extraGroups = [ "networkmanager" "docker" ];
      openssh.authorizedKeys.keys = [  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEdQDJEnAKSK5MECKcpzcNFgPSs0BnHwCi53U88YTFN tyler" ];
    };

    users.users.root.initialHashedPassword = "$y$j9T$aXXv9hEOFeM5CTpHF/X8k0$zKNxX3lYxX1dNDHFOHn5kM/muWkYYB1Gvz96HzBXPR8"
  };
}
