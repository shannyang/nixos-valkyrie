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
  timeZone = "America/Los_Angeles";
  hostName = "brynhildr";
  stateVersion = "25.05";
  overlays = import ../../modules/overlays.nix;
in
{

  imports = [
    ./hardware-configuration.nix
    ../../modules/hypr-desktop.nix
    ../../modules/icewm-desktop.nix
    ../../modules/sound.nix
    ../../modules/theme.nix
    ../../modules/locale.nix
    ../../modules/theme.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  hardware.bluetooth.enable = true;
  services.udisks2.enable = true;
  services.printing.enable = true;
  services.upower.enable = true;

  services.journald.extraConfig = "SystemMaxUse=100M";

  networking = {
    hostName = hostName;
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall.allowedTCPPorts = [ ];
  };

  virtualisation = {
    docker.enable = true;
    waydroid.enable = true;
  };

  hardware = {
    graphics.enable = true;
    graphics.extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
    ];
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
  };

  valkyrie-desktop = {
    hypr = {
      enable = true;
      greetd = true;
    };
    icewm.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [

    # Basic utilities
    git
    vim
    wget
    tmux
    gum
    bottles
    appimage-run

    # Monitoring
    fastfetch
    mangohud
    
    # Caelestia
    inputs.caelestia-cli.packages.x86_64-linux.with-shell

    # Gaming
    protonup-qt
    (heroic.override {
      extraPkgs = pkgs: [
        pkgs.gamescope
      ];
    })
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
