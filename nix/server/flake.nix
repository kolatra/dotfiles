{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-24.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    mms.url = "github:mkaito/nixos-modded-minecraft-servers";

    # for handling secrets
    agenix.url = "github:ryantm/agenix";
  };

  outputs = { self, nixpkgs, home-manager, mms, agenix, ... }@inputs: let inherit (self) outputs; in {
    nixosConfigurations = {
        titan = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = {inherit inputs outputs;};
            modules = [
                ./cfg/configuration.nix
                agenix.nixosModules.default

                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.users.tyler = import ./homes/titan.nix;
                    home-manager.sharedModules = [

                    ];
                }
            ];
        };
    };
  };
}
