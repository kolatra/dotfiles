# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let
topology = inputs.nix-topology;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./topology.nix
      ../../modules/desktop/kde
    ];

  # Bootloader.
  # systemd-boot is recommended over GRUB for gpt schemes
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # supposed to make the battery last longer
  services.system76-scheduler.settings.cfsProfiles.enable = true;
  services.thermald.enable = true;
  powerManagement.powertop.enable = true;

  environment.sessionVariables = {
    # Prevent Firefox from creating ~/Desktop
    XDG_DESKTOP_DIR = "$HOME";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  systemd.network.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  networking.hostName = "tethys"; # Define your hostname.

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    # These users have additional rights when connecting to the nix daemon
    # Such as specifying additional binary caches
    trusted-users = [
      "root"
      "tyler"
    ];
  };

  # enable internet
  networking.networkmanager.enable = true;

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tyler = {
    isNormalUser = true;
    # initialPassword = "correcthorse";
    initialHashedPassword = "$y$j9T$EuTlDpQ6.PVZXOP7uuzNE/$UAqgMOoXZ0BVV95qIw03KFwFPhNj7vvfV0a593h.9rD";
    description = "Tyler";
    extraGroups = [ "networkmanager" "wheel" "audio" "video" "docker" ];
    packages = with pkgs; [];
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFvgVYsV2xIxo2o8QKyt8CA2yKn+qU9AHLq5V7SRP8Xa tyler@artalok.io" ];
    shell = pkgs.zsh;
  };

  users.users.root.initialHashedPassword = "$y$j9T$EuTlDpQ6.PVZXOP7uuzNE/$UAqgMOoXZ0BVV95qIw03KFwFPhNj7vvfV0a593h.9rD";

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
     wget
     unzip
     libgcc
     gcc15
     p7zip
     git
     btop
     brightnessctl
     just
     eza
     fastfetch
     bat
     yazi
     fzf
     ripgrep
     home-manager

     # required to make pyright work in nvim
     nodejs
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.zsh.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
  programs.java.enable = true;

  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.settings = {
    X11Forwarding = true;
    PermitRootLogin = "no";
    PasswordAuthentication = false;
  };
  services.openssh.openFirewall = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "25.05";

}
