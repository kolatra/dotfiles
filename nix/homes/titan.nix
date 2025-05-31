{ inputs, config, pkgs, ... }: 
let user = "tyler"; 
in {
    imports = [

    ];

    home = {
        username = "${user}";
        homeDirectory = "/home/${user}";
    };

    programs.neovim.enable = true;

    programs.firefox.enable = true;

    home.packages = with pkgs; [
        zsh
        oh-my-zsh
    ];

    home.file.".zshrc" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/${user}/.dotfiles/zsh/.zshrc";
    };

    home.file.".config/nvim" = {
        source = config.lib.file.mkOutOfStoreSymlink "/home/${user}/.dotfiles/nvim";
    };

    programs.home-manager.enable = true;

    programs.git = {
        enable = true;
        userName = "${user}";
        userEmail = "3821892+kolatra@users.noreply.github.com";
    };

    systemd.user.startServices = "sd-switch";

    home.stateVersion = "24.11";
}
