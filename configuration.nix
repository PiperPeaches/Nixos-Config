{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      (builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz" + "/nixos")
      ./boot/boot.nix
      ./network/network.nix
      ./user/user.nix
      ./apps/apps.nix
      ./hardware/hardware.nix
    ];

  system.stateVersion = "25.11"; # Did you read the comment?

  # Home Manager configuration
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.piper = import ./user/home.nix;

}