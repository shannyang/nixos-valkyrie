{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{

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
}