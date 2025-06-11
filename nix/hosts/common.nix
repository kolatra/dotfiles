{ config, pkgs, ... }:

{
    networking.networkmanager.enable = true;
    time.timeZone = "America/Edmonton";
    i18n.defaultLocale = "en_CA.UTF-8";

    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    nixpkgs.config.allowUnfree = true;
    nixpkgs.config.allowUnfreePredicate = _: true;

    environment.systemPackages = with pkgs; [
        neovim
        git
        zsh
        oh-my-zsh # see if I can shell script this in the config instead
        btop
        wget
        gnumake
        gcc15
        unzip
        fastfetch
    ];

    services.tailscale.enable = true;

    services.openssh = {
      enable = true;
      settings = {
        X11Forwarding = true;
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
}
