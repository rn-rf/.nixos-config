{ pkgs, unstable, ... }:

{
    environment.systemPackages = with pkgs; [ wget
        git
        tree
        vim
        neovim
        tmux
        unzip
        jq
        gcc
        python3
        nodejs
        jdk

        ghostty
        alacritty

        swww
        waybar
        socat
        wofi
        grim
        slurp
        wl-clipboard

        libnotify
        swaynotificationcenter

        networkmanagerapplet
        bibata-cursors
        adw-gtk3
        brightnessctl
        pamixer
        playerctl
        ];

    programs.firefox.enable = true;
}
