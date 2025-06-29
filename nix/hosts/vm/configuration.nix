{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "vm"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
  users.users.root.password = "root";

  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        user = "root";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd /run/current-system/sw/bin/bash";
      };
    };
  };

  time.timeZone = "America/Edmonton";

  i18n.defaultLocale = "en_US.UTF-8";

  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
  ];

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  services.openssh.enable = true;

  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  system.copySystemConfiguration = true;

  system.stateVersion = "25.05";
}

