{ config, pkgs, ... }:

{
  home.username = "rn";
  home.homeDirectory = "/home/rn";

  home.stateVersion = "25.11";

  imports = [
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    brave
    vscode
    telegram-desktop
    gnome-tweaks
    nwg-look
    pywal
    neofetch
    tela-circle-icon-theme
  ];

  programs.git.enable = true;

  programs.bash.enable = true;

  fonts.fontconfig.enable = true;
}
