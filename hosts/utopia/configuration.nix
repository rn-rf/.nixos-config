{ config, pkgs, unstable, ... }:

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
    extraGroups = [ "wheel" "networkmanager" "bluetooth" ];
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
