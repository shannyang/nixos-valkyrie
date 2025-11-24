{
  config,
  lib,
  pkgs,
  inputs,
  options,
  ...
}:
let
  username = "shannony";
  userDescription = "Shannon Yang";
  hostName = "kara";
  stateVersion = "25.05";
  overlays = import ../../modules/overlays.nix;
in
{

  nixpkgs.overlays = [
    overlays.discord-overlay
  ];

  imports = [
    ./hardware-configuration.nix
    ../../modules/hypr-desktop.nix
    ../../modules/sound.nix
    ../../modules/theme.nix
    ../../modules/locale.nix
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
  ];

  # Boot
  boot.loader = {
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
    bluetooth.enable = true;
  };

  services.udisks2.enable = true;
  services.printing.enable = true;

  services.journald.extraConfig = "SystemMaxUse=100M";

  networking = {
    hostName = hostName;
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall.allowedTCPPorts = [ ];
  };

  virtualisation = {
    docker.enable = true;
  };

  valkyrie-desktop.hypr = {
    enable = true;
    greetd = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs = {
    steam.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  environment.systemPackages = with pkgs; [

    # Basic utilities
    git
    vim
    wget
    tmux
    gum

    # Monitoring
    fastfetch
    htop
  ];

  users = {
    mutableUsers = true;
    users.${username} = {
      isNormalUser = true;
      description = userDescription;
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
      ];
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  home-manager = {
    extraSpecialArgs = {inherit inputs; };
    users.${username} = import ./user.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  system.stateVersion = stateVersion;

}
