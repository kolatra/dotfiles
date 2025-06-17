{ config, pkgs, lib, ... }:

{
  home = {
    username = "tyler";
    homeDirectory = "/home/tyler";
    stateVersion = "25.05";

    packages = with pkgs; [
        kitty
        discord
        obsidian
        spotify
        bitwarden-desktop
        bitwarden-cli
        element-desktop
        thunderbird

        jetbrains-mono

        (writeShellScriptBin "rsync-backup" ''
          rsync -avh -e ssh --delete ~ "192.168.1.77:/hdd/backups/$HOSTNAME"
        '')

        # connect to titan
        (writeShellScriptBin "takeoff" ''
          ssh 192.168.1.77
        '')
    ];

    file = {
      ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink "/home/tyler/.dotfiles/kitty";
      ".config/fastfetch".source = config.lib.file.mkOutOfStoreSymlink "/home/tyler/.dotfiles/fastfetch";
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/tyler/.dotfiles/nvim";
      ".zshrc".source = config.lib.file.mkOutOfStoreSymlink "/home/tyler/.dotfiles/zsh/.zshrc";
      "scripts".source = config.lib.file.mkOutOfStoreSymlink "/home/tyler/.dotfiles/scripts";
    };

    # tyler todo: put this in .zshrc?
    # source ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.firefox.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  systemd.user.startServices = "sd-switch";

  programs.git = {
      enable = true;
      userName = "Tyler";
      userEmail = "3821892+kolatra@users.noreply.github.com";
  };
}
