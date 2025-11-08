{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.valkyrie-desktop.hypr;
in {

  options.valkyrie-desktop.hypr = {
    enable = lib.mkEnableOption "Valkyrie desktop";
    greetd = lib.mkEnableOption "tuigreet with hyprland default";
  };

  config = lib.mkIf cfg.enable {
    services.greetd = lib.mkIf cfg.greetd {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd hyprland";
        };
      };
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    environment.systemPackages = with pkgs; [
      # utils
      grim
      slurp

      # controls
      brightnessctl
      pavucontrol
      playerctl

      # hyprland and desktop utils
      foot
      yazi
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
  };
}