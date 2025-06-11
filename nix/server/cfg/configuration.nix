# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./users.nix
      ./ssh.nix
      ./minecraft.nix
      ./samba.nix
      ./restic.nix
      ./pihole.nix
    ];

  age.identityPaths = [ "/home/tyler/.ssh/id_titan" ];

  system.stateVersion = "24.11";

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "titan"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable experimental settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = _: true;

  environment.systemPackages = with pkgs; [
     git
     bash
     zsh
     oh-my-zsh
     btop
     gnumake
     gcc
     neovim
     wget
     fastfetch
     just
     unzip
     bat
  ];

  environment.variables.EDITOR = "nvim";

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  programs.zsh.enable = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.ohMyZsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
          "sudo"
      ];
  };

  services.tailscale.enable = true;
  services.nginx = {
      enable = true;
      user = "tyler";
      group = "users";

      virtualHosts."artalok.io" = {
          root = "/var/www/site";
      };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 80 443 8123 ];
  networking.firewall.allowedUDPPorts = [ 80 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  
  virtualisation.docker.enable = true;
}
