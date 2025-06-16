{ config, pkgs, ... }:

{
    imports = [ ../common.nix ];

    services.desktopManager.plasma6.enable = true;
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
}
