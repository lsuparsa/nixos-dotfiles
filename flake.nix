{

  description = "Flake v0.1";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... } @ inputs :
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
	  inherit system;
	  specialArgs = { inherit inputs; };
	  modules = [
            ./configuration.nix
	  ];
        };
      };
      homeConfigurations = {
        luka = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;
	  modules = [
            ./home.nix
	  ];
	};
      };
  };

}
