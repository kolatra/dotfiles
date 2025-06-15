{ config, pkgs, ... }:

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
      ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink ../../../kitty;
      ".config/fastfetch".source = config.lib.file.mkOutOfStoreSymlink ../../../fastfetch;
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink ../../../nvim;
      ".zshrc".source = config.lib.file.mkOutOfStoreSymlink ../../../zsh/.zshrc;
      "scripts".source = config.lib.file.mkOutOfStoreSymlink ../../../scripts;
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. These will be explicitly sourced when using a
    # shell provided by Home Manager. If you don't want to manage your shell
    # through Home Manager then you have to manually source 'hm-session-vars.sh'
    # located at either
    #
    # tyler todo: put this in .zshrc?
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

  programs.firefox.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
      enable = true;
      userName = "Tyler";
      userEmail = "3821892+kolatra@users.noreply.github.com";
  };
}
