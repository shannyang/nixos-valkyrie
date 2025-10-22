{ config, lib, pkgs, ... }:
let
  userName = "shannony";
  stateVersion = "25.05";
in
  {

    programs.home-manager.enable = true;
    stylix = {
        enable = true;
        base16Scheme = ../../color/sunset.yaml;
        polarity = "dark";
    };

    home = {

      username = userName;
      homeDirectory = "/home/${userName}";
      stateVersion = stateVersion;

      packages = with pkgs; [
        # Programming
        vscode
        neovim
        openssl

        # Browser
        firefox

        # Social
        discord
        signal-desktop

        # File management
        keepassxc
        rclone
        yazi
        unzip
        unrar
        zip
        calibre

        # Content
        krita
        obs-studio
        libreoffice-qt6

        # Utils
        imagemagick
        mpv
        kew
        qmk
      ];

      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        TERMINAL = "kitty";
        BROWSER = "firefox";
      };

      file = {
        # Config symlinks
        ".gitconfig".source = ../../dotfiles/.gitconfig;
        ".config/yazi".source = ../../dotfiles/.config/yazi;
        ".config/hypr".source = ../../dotfiles/.config/hypr;
        ".config/waybar".source = ../../dotfiles/.config/waybar;
        ".config/wlogout".source = ../../dotfiles/.config/wlogout;
        ".config/kitty".source = ../../dotfiles/.config/kitty;
        ".config/wofi".source = ../../dotfiles/.config/wofi;
        ".config/fastfetch".source = ../../dotfiles/.config/fastfetch;
      };

    };
  }
