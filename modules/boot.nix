{ ... }:

{
  boot.loader.systemd-boot.enable = false;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    default = "saved";
  };

  boot.loader.efi.canTouchEfiVariables = true;
}
