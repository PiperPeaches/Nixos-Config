{ config, pkgs, ... }:

{
  home.username = "piper";
  home.homeDirectory = "/home/piper";
  home.stateVersion = "23.11"; # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;
  programs.bash.enable = true;
  # Add your home-manager packages here
  home.packages = with pkgs; [
    git
    htop
  ];
}