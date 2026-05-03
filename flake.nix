{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    affinity-nix.url = "github:mrshmllow/affinity-nix";
  };

  outputs = { self, nixpkgs, home-manager, affinity-nix, ... }@inputs: {
    # Check your hostname with 'hostname' command; replace "nixos" if it's different.
    nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        # 1. Add the Affinity Overlay and Package to the System
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ affinity-nix.overlays.default ];
          environment.systemPackages = [ pkgs.affinity-v3 ];
        })

        # 2. Integrate Home Manager so you don't need the standalone command
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.piper = import ./user/home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}