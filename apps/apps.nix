{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  # Display Manager
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Desktop Environments
  services.desktopManager.plasma6.enable = true;
  programs.hyprland.enable = true;
  
  # GNOME (Make sure there is NO "xserver" in this line)
  services.desktopManager.gnome.enable = true;

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
  services.pulseaudio.enable = false;
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
    localNetworkGameTransfers.openFirewall = true; 
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    cudatoolkit
    slack
    nodejs
    gemini-cli-bin
    kitty
    wget
    vscode
    fastfetch
    davinci-resolve-studio
    wine
    winetricks
    python3
    bazaar
    vesktop
  ];

  services.flatpak.enable = true;

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