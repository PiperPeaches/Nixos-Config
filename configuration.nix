{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      # (builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz" + "/nixos")
      ./boot/boot.nix
      ./network/network.nix
      ./user/user.nix
      ./apps/apps.nix
      ./hardware/hardware.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";

  # Home Manager configuration
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.piper = import ./user/home.nix;

}