{
  description = "Nixos config flake";

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    trusted-users = [
      "root"
    ];

    warn-dirty = false;
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # graphical overview of infrastructure
    nix-topology.url = "github:oddlama/nix-topology";
    flake-utils.url = "github:numtide/flake-utils";
    mms.url = "github:mkaito/nixos-modded-minecraft-servers";

    # for handling secrets
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.tethys = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/laptop/configuration.nix
        inputs.nix-topology.nixosModules.default
        inputs.agenix.nixosModules.default
      ];
    };

    nixosConfigurations.titan = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/server/configuration.nix
        inputs.agenix.nixosModules.default
        inputs.nix-topology.nixosModules.default
        inputs.home-manager.nixosModules.default
        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tyler = ./home-manager/server/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  }
    // inputs.flake-utils.lib.eachDefaultSystem (system: rec {
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = [inputs.nix-topology.overlays.default];
      };
      topology = import inputs.nix-topology {
        inherit pkgs;
        modules = [
          ./topology.nix
          { nixosConfigurations = self.nixosConfigurations; }
        ];
      };
    });
}
