{
  description = "Utopia NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zenbrowser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      unstable,
      home-manager,
      zenbrowser,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.Utopia = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/utopia/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit zenbrowser unstable;
            };
            home-manager.users.rn = import ./home/rn.nix;
          }
        ];

        specialArgs = {
          inherit unstable zenbrowser;
        };
      };
    };
}
