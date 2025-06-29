<<<<<<< HEAD
=======
# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

>>>>>>> 7f29cec (sync)
{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

<<<<<<< HEAD
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "vm";
  networking.networkmanager.enable = true;

  time.timeZone = "America/Edmonton";

  i18n.defaultLocale = "en_US.UTF-8";

  users.users.root.password = "root";

=======
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "vm"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

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

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # users.users.alice = {
  #   isNormalUser = true;
  #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     tree
  #   ];
  # };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
>>>>>>> 7f29cec (sync)
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

