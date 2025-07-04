{ config, pkgs, inputs, ... }:

let
topology = inputs.nix-topology;
user = "tyler";
in
{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./topology.nix
      ../../modules/desktop/kde
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.plymouth.enable = true;

  age.identityPaths = [ "/home/${user}/.ssh/id_ed25519" ];

  environment.sessionVariables = {
    # Prevent Firefox from creating ~/Desktop
    XDG_DESKTOP_DIR = "$HOME";
  };

  networking = {
    hostName = "tethys";
    networkmanager.enable = true;
  };

  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" ];
    };
  };

  systemd = {
    network.enable = true;
  };

  powerManagement.powertop.enable = true;
  services = {
    system76-scheduler.settings.cfsProfiles.enable = true;
    thermald.enable = true;

    gvfs.enable = true;
    udisks2.enable = true;

    greetd = {
      enable = true;
      vt = 3;
      settings = {
        default_session = {
          user = "${user}";
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd startplasma-wayland";
        };
      };
    };


    openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    blueman.enable = true;

    xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };

  security.rtkit.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tyler = {
    isNormalUser = true;
    # initialPassword = "";
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
     bat
     bitwarden-cli
     bitwarden-desktop
     btop
     discord
     element-desktop
     eza
     fastfetch
     fzf
     gcc15
     git
     just
     kitty
     krita
     libgcc
     maliit-framework
     maliit-keyboard
     nodejs
     obsidian
     p7zip
     ripgrep
     spotify
     thunderbird
     unzip
     wget
     yazi
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
    };

    neovim = {
      enable = true;
      defaultEditor = true;
    };

    firefox.enable = true;

    appimage = {
      enable = true;
      binfmt = true;
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };

    java.enable = true;

    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };

  networking.firewall.allowedTCPPorts = [];
  networking.firewall.allowedUDPPorts = [];

  system.stateVersion = "25.05";

}
