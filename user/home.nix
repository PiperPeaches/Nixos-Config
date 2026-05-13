{ config, pkgs, inputs, ... }:

{
  home.username = "piper";
  home.homeDirectory = "/home/piper";
  home.stateVersion = "23.11"; 
  
  # Please read the comment before changing.
  home.enableNixpkgsReleaseCheck = false;
  programs.bash.enable = true;

  home.file.".config/fastfetch".source = ../apps/fastfetch;
  home.file.".config/ghostty".source = ../apps/ghostty;
  
  # Add your home-manager packages here
  home.packages = with pkgs; [
    # Terminal Utilities
    git
    htop

    # Hyprland and related tools
    swaybg
    waypaper

    # Gnome Extensions
    gnomeExtensions.hide-top-bar
    gnomeExtensions.search-light
    gnomeExtensions.gsconnect
    gnomeExtensions.desktop-cube
    gnomeExtensions.clipboard-indicator
    gnomeExtensions.blur-my-shell
    gnomeExtensions.user-themes
  ];

  dconf.settings."org/gnome/shell" = {
    disable-user-extensions = false;
    enabled-extensions = [
      "hidetopbar@mathieu.bidon.ca"
      "search-light@icedman.github.com"
      "peek-bar@rachalaraj.github.com"
      "message-notifier@shell-extensions.barisione.org"
      "gsconnect@andyholmes.github.io"
      "desktop-cube@schneegans.github.com"
      "clipboard-indicator@tudmotu.com"
      "blur-my-shell@aunetx"
      "user-theme@gnome-shell-extensions.gcampax.github.com"
    ];
  };
}
