{

  description = "Master Flake";

  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } :
    let
      lib = nixpkgs.lib;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations = {
	  # Syntax to follow $HOSTNAME = lib.nixosSystem etc.
          nixos = lib.nixosSystem {
	    inherit system;
            modules = [ ./configuration.nix ];
	    };
        };
      homeConfigurations = {
        # Syntax to follow: $USERNAME = home-manager.lib.homeManagerConfiguration etc.
        wajid = home-manager.lib.homeManagerConfiguration {
	  inherit pkgs;
	  modules = [ ./home.nix ];
        };
      };
  };

}
