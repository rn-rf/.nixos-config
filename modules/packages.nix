{ pkgs, unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    git
    vim
    neovim
    tmux
    unzip
    jq
    gcc
    nodejs
    jdk

    ghostty
    alacritty

    swww
    waybar
    wofi
    grim
    slurp
    wl-clipboard

    libnotify
    swaynotificationcenter

    networkmanagerapplet
    brightnessctl
    pamixer
    playerctl
  ];

  programs.firefox.enable = true;
}
