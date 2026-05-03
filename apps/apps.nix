{ config, pkgs, inputs, ... }:

{
  services.xserver.enable = true;

  # Display Manager
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.displayManager.sddm.wayland.enable = true;

  # Desktop Environments
  services.xserver.desktopManager.plasma5.enable = true;
  programs.hyprland.enable = true;
  
  # GNOME (Make sure there is NO "xserver" in this line)
  services.xserver.desktopManager.gnome.enable = true;

  # FIX: Tell NixOS to ignore the SSH password conflict
  programs.ssh.askPassword = pkgs.lib.mkForce "";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; 
    dedicatedServer.openFirewall = true; 
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    cudatoolkit
    slack
    nodejs
    kitty
    wget
    vscode
    fastfetch
    davinci-resolve-studio
    wine
    winetricks
    python3
    waybar
    waypaper
    swaybg
    vesktop
    wofi
    vlc
  ];

  services.flatpak.enable = true;
  programs.fish.enable = true;
  programs.kdeconnect.enable = true;

  # Fonts
  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Noto Serif" ];
        sansSerif = [ "Noto Sans CJK JP" "Noto Sans" ];
        monospace = [ "Noto Sans Mono CJK JP" "Noto Sans Mono" ];
      };
    };
  };
}
