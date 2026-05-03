{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Ensure home-manager uses the same nixpkgs
    affinity-nix.url = "github:mrshmllow/affinity-nix";
    affinity-nix.inputs.nixpkgs.follows = "nixpkgs-unstable";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    affinity-nix,
    ...
  }: {
    nixosConfigurations.my-system = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux"; # Assuming x86_64-linux
      specialArgs = { inherit inputs; };
      modules = [
        # Import the existing configuration.nix as a module
        ./configuration.nix

        # Home Manager module
        home-manager.nixosModules.home-manager

        # User-requested overlay and package from unstable to fix build errors on 23.11
        ({ pkgs, config, ... }: 
        let
          pkgs-unstable = import nixpkgs-unstable {
            inherit (pkgs) system;
            config.allowUnfree = true;
            overlays = [ affinity-nix.overlays.default ];
          };
        in {
          environment.systemPackages = [ pkgs-unstable.affinity-v3 ];
        })
      ];
    };
  };
}