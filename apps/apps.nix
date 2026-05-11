{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  # Display Manager
  services.displayManager.gdm.enable = true;
  # services.displayManager.sddm.wayland.enable = true;

  # Desktop Environments
  services.desktopManager.plasma6.enable = false;
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

  # firefox.
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

  nixpkgs.overlays = [
    (final: prev: {
      davinci-resolve-studio-unwrapped = prev.davinci-resolve-studio-unwrapped.overrideAttrs (old: {
        src = /tmp/DaVinci_Resolve_Studio_20.3.2_Linux.zip;
        # Use the 'got' hash from your error message here
        outputHash = "1ypc0nn84wcnxk7wz6s6ccarqs8l33z0qw037wj59kpik7k820i6";
        outputHashAlgo = "sha256";
        outputHashMode = "flat";
      });
    })
  ];

  environment.systemPackages = with pkgs; [
    # Legal Activities
    qbittorrent
    tor-browser

    # Office
    libreoffice-still
    
    #flatpak
    bazaar

    # Communication
    slack
    vesktop

    # Terminal apps and utilities
    ghostty 
    fastfetch

    # Compatibility Layers
    wine
    winetricks

    # NVIDIA
    cudatoolkit
    cudaPackages.cuda_nvcc
    cudaPackages.libcublas
    nvtopPackages.nvidia
    nvidia-vaapi-driver

    # GNOME
    gdm-settings
    gnome-tweaks

    # Programming
    wget 
    git
    nodejs
    gemini-cli-bin
    python3
    vscode
    jdk21

    # Music & Video
    davinci-resolve-studio
    vlc
    spotify

    # Packaged Fonts
    wine64Packages.fonts
  ];

  services.flatpak.enable = true;
}