{
  config,
  zenbrowser,
  pkgs,
  ...
}:
{
  home.username = "rn";
  home.homeDirectory = "/home/rn";

  home.stateVersion = "25.11";

  imports = [
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

    zenbrowser.packages.${pkgs.system}.default
  ];

  programs.git.enable = true;
  programs.bash.enable = false;
  fonts.fontconfig.enable = true;
  programs.waybar.enable = true;

  # Uncomment the below if you want fixed config and comment next block
  # xdg.configFile."hypr".source = ../dotfiles/hypr;
  # xdg.configFile."waybar".source = ../dotfiles/waybar;
  # xdg.configFile."ghostty".source = ../dotfiles/ghostty;
  # xdg.configFile."tmux".source = ../dotfiles/tmux;
  # home.file.".bashrc".source = ../dotfiles/.bashrc;

  # comment the below if you want fixed config and uncomment above block
  xdg.configFile."hypr".source =
    config.lib.file.mkOutOfStoreSymlink "/home/rn/.nixos-config/dotfiles/hypr";
  xdg.configFile."waybar".source =
    config.lib.file.mkOutOfStoreSymlink "/home/rn/.nixos-config/dotfiles/waybar";
  xdg.configFile."ghostty".source =
    config.lib.file.mkOutOfStoreSymlink "/home/rn/.nixos-config/dotfiles/ghostty";
  xdg.configFile."tmux".source =
    config.lib.file.mkOutOfStoreSymlink "/home/rn/.nixos-config/dotfiles/tmux";
  home.file.".bashrc".source =
    config.lib.file.mkOutOfStoreSymlink "/home/rn/.nixos-config/dotfiles/.bashrc";
}
