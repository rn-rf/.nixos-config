{ config, pkgs, ... }:

{
  home.username = "rn";
  home.homeDirectory = "/home/rn";

  home.stateVersion = "25.11";

  imports = [
    ./hyprland.nix
    ./neovim.nix
  ];

  home.packages = with pkgs; [
    brave
    vscode
    telegram-desktop
    gnome-tweaks
    nwg-look
    pywal
    inkscape-with-extensions
    gimp2
    neofetch
    tela-circle-icon-theme
  ];

  programs.git.enable = true;
  programs.bash.enable = false;
  fonts.fontconfig.enable = true;

  xdg.configFile."hypr".source = ../dotfiles/hypr;
  xdg.configFile."waybar".source = ../dotfiles/waybar;
  xdg.configFile."ghostty".source = ../dotfiles/ghostty;
  xdg.configFile."tmux".source = ../dotfiles/tmux;

  home.file.".bashrc".source = ../dotfiles/.bashrc;
  # home.file.".local/bin/toggal".source =
  # ../dotfiles/waybar/scripts/one_window.sh;

}
