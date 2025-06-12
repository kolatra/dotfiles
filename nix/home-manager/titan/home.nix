{ inputs, config, pkgs, ... }: 
let user = "tyler"; 
in {
    imports = [

    ];

    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
        packages = with pkgs; [];
        file = {
            ".zshrc".source = ../../../zsh/.zshrc;
            ".config/nvim".source = ../../../nvim;
        };
    };

    programs.neovim.enable = true;

    programs.home-manager.enable = true;

    programs.git = {
        enable = true;
        userName = "${user}";
        userEmail = "3821892+kolatra@users.noreply.github.com";
    };

    systemd.user.startServices = "sd-switch";

    home.stateVersion = "24.11";
}
