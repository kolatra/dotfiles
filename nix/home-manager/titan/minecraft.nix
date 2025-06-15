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
            "new-horizons" = {
                source = null;
                recursive = true;
            };
        };
    };

    programs = {
        neovim.enable = true;
        home-manager.enable = true;
    };
};
