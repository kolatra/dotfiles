{ config, pkgs, inputs, ... }:

{
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
    # latte-dock
    # plasma-panel-colorizer
    spotify
    thunderbird
    unzip
    wget
    yazi
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      ohMyZsh.enable = true;
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
}
