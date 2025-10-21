{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  services.greetd = {
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
}