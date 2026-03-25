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
        extraGroups = ["wheel"
            "networkmanager"
            "bluetooth"
            "docker"
        ];
    };

    nix.settings.experimental-features = ["nix-command"
            "flakes"
    ];

    programs.hyprland.enable = true;
    nixpkgs.config.allowUnfree = true;
    system.stateVersion = "25.11";
    programs.nix-ld.enable = true;
    virtualisation.docker.enable = true;


    services.kanata = {
        enable = true;

        keyboards.default = {
            configFile = ../../dotfiles/kanata/kanata.kbd;
        };
    };

    security.sudo.extraRules = [
    {
        users = [ "rn" ];
        commands = [
        {
            command = "/run/current-system/sw/bin/systemctl start kanata-default";
            options = [ "NOPASSWD" ];
        }
        {
            command = "/run/current-system/sw/bin/systemctl stop kanata-default";
            options = [ "NOPASSWD" ];
        }
        ];
    }
    ];

}
