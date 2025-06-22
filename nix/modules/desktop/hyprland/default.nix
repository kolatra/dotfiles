{ config, lib, pkgs, ... }:

{
    imports = [ ../common.nix ];

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
        ;
    };
}
