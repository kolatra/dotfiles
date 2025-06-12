{ config, pkgs, inputs, ... }:

{
  age.secrets = {
    "restic/env".file = ../secrets/restic/env.age;
    "restic/repo".file = ../secrets/restic/repo.age;
    "restic/password".file = ../secrets/restic/password.age;
  };

  services.restic.backups = {
    daily = {
      initialize = true;

      environmentFile = config.age.secrets."restic/env".path;
      repositoryFile = config.age.secrets."restic/repo".path;
      passwordFile = config.age.secrets."restic/password".path;

      # adjust these as needed
      paths = [
        "/home"
        "/hdd/backups/"
        "/hdd/isos"
        "/hdd/gtnh-world/"
        "/hdd/home-folder"
        "/hdd/home-backup"
        "/hdd/photos"
        "/hdd/wendy-photos"
        "/hdd/misc"
      ];

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };
}
