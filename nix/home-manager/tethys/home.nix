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
        element-desktop

        jetbrains-mono

        (pkgs.writeShellScriptBin "rsync-backup" ''
          rsync -avh -e ssh --delete ~ "192.168.1.77:/hdd/backups/$HOSTNAME"
        '')
    ];

    file = {
      ".config/kitty".source = ../../../kitty;
      ".config/fastfetch".source = ../../../fastfetch;
      ".config/nvim".source = ../../../nvim;
      ".zshrc".source = ../../../zsh/.zshrc;
      "scripts".source = ../../../scripts;
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
