{ config, pkgs, ... }:

{
    imports = [ ../common.nix ];

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    config.environment.systemPackages = with pkgs; [
        waybar
    ] ++ config.environment.systemPackages; # add to existing list
}
