{ inputs, config, pkgs, ... }:

let user = "minecraft";
in
{
    imports = [];

    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
        # install any needed profiling applications here
        packages = with pkgs; [];
        file = {
            ".zshrc".source = ../../../zsh/.zshrc;
            ".config/nvim".source = ../../../nvim;
            "gtnh/docker-compose.yml".source = ../../modules/containers/gtnh/docker-compose.yml
            "monifactory/docker-compose.yml".source = ../../modules/containers/monifactory/docker-compose.yml
            "satisfactory/docker-compose.yml".source = ../../modules/containers/satisfactory/docker-compose.yml
            "gtnh.zip" = {
                source = pkgs.fetchurl {
                    url = "https://downloads.gtnewhorizons.com/ServerPacks/GT_New_Horizons_2.7.4_Server_Java_17-21.zip";
                    sha256 = "2348e1940fce412946d3207323b6f7d37ad771879a0b01a7d4dda7025ce19da2";
                };
            };
        };
    };

    programs = {
        neovim.enable = true;
        home-manager.enable = true;
    };
};
