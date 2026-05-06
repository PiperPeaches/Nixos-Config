{ config, pkgs, ... }:

{
  # Cuda x Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Asus Linux
  services.asusd.enable = true;
  # services.asusd.enableUserService = true;
  services.supergfxd.enable = true;
}