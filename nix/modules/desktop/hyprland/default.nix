{ config, lib, pkgs, ... }:

{
    imports = [ ../common.nix ];

    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    environment.systemPackages = lib.attrValues {
        inherit (pkgs)
            waybar
            brightnessctl
            wl-clipboard
            wtype
            xdg-utils
            hyprpaper
            hyprlock
            hypridle
            rofi-wayland
        ;
    };
}
