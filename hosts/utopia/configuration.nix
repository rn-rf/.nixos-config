{
  config,
  pkgs,
  unstable,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix

    ../../modules/boot.nix
    ../../modules/networking.nix
    ../../modules/locale.nix
    ../../modules/desktop.nix
    ../../modules/audio.nix
    ../../modules/bluetooth.nix
    ../../modules/printing.nix
    ../../modules/packages.nix
  ];

  networking.hostName = "Utopia";

  users.users.rn = {
    isNormalUser = true;
    description = "Aryan Rathod";
    extraGroups = [
      "wheel"
      "networkmanager"
      "bluetooth"
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.hyprland.enable = true;
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
  programs.nix-ld.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    open = false;
    prime = {
      offload.enable = true;
      offload.enableOffloadCmd = true;
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
