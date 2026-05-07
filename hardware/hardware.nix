{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaPersistenced = true; 
  };

  # Direct environment injection for CUDA libraries
  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib:/run/opengl-driver-32/lib";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Asus Linux specific services
  services.asusd.enable = true;
  services.supergfxd.enable = true;
}