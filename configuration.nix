{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix

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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Disable systemd-oomd
  systemd.oomd.enable = false;
}