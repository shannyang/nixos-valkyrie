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
  hostName = "valkyrie";
  stateVersion = "25.05";
in
{
  imports = [
    ./hardware-configuration.nix
    ./theme.nix
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
  ];

  # Set your time zone.
  time.timeZone = timeZone;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Boot
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
    useOSProber = true;
  };
  boot.loader.efi = {
    canTouchEfiVariables = true;
    efiSysMountPoint = "/boot";
  };

  hardware.bluetooth.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd hyprland";
        user = username;
      };
    };
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.steam.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  networking = {
    hostName = hostName;
    networkmanager.enable = true;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
    firewall.allowedTCPPorts = [ ];
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    wireplumber.extraConfig.no-ucm = {
      "monitor.alsa.properties" = {
        "alsa.use-ucm" = false;
      };
    };
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  virtualisation = {
    docker.enable = true;
  };

  hardware = {
    graphics.enable = true;
    nvidia.modesetting.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [

    # Basic utilities
    kitty
    git
    vim
    wget
    tmux
    gum
    grim
    slurp
    brightnessctl
    pavucontrol
    playerctl
    libreoffice-qt6

    # Monitoring
    fastfetch
    htop
    mangohud

    # hyprland and desktop utils
    pyprland
    waybar
    swww
    dunst
    hypridle
    hyprlock
    wl-clipboard
    libnotify
    wofi
    networkmanagerapplet
    bluetui
    wlogout
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

  services.printing.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  home-manager = {
    extraSpecialArgs = {inherit inputs; };
    users.${username} = import ./home.nix;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  system.stateVersion = stateVersion;

}
