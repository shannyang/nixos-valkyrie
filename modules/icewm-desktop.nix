{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
let
  cfg = config.valkyrie-desktop.icewm;
in {

  options.valkyrie-desktop.icewm = {
    enable = lib.mkEnableOption "icewm desktop";
    greetd = lib.mkEnableOption "tuigreet with icewm default";
  };

  config = lib.mkIf cfg.enable {
    services.greetd = lib.mkIf cfg.greetd {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd icewm";
        };
      };
    };

    services.xserver = {
      enable = true;
      displayManager.startx.enable = true;
      windowManager.icewm.enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

    services.picom.enable = true;

    environment.systemPackages = with pkgs; [
      # desktop utils
      yazi
      rofi
      networkmanagerapplet
      bluetui
    ];
  };
}