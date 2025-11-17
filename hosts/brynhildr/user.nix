{ config, lib, pkgs, ... }:
let
  userName = "shannony";
  stateVersion = "25.05";
in
  {

    programs = {
      home-manager.enable = true;
      direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };
      bash = {
        enable = true;
          shellAliases = import ../../modules/shell-aliases.nix;
      };
    };

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
        tor-browser

        # Social
        discord
        signal-desktop

        # File management
        keepassxc
        rclone
        unzip
        unrar
        zip
        (calibre.override {
          unrarSupport = true;
        })

        # Content
        krita
        obs-studio
        libreoffice-qt6
        kew

        # Utils
        imagemagick
        pureref
        mpv
        qmk
      ];

      sessionVariables = {
        EDITOR = "nvim";
        VISUAL = "nvim";
        TERMINAL = "foot";
        BROWSER = "firefox";
      };

      file = {
        # Config symlinks
        ".gitconfig".source = ../../dotfiles/.gitconfig;
        ".config/yazi".source = ../../dotfiles/.config/yazi;
        ".config/waybar".source = ../../dotfiles/.config/waybar;
        ".config/wlogout".source = ../../dotfiles/.config/wlogout;
        ".config/foot".source = ../../dotfiles/.config/foot;
        ".config/rofi".source = ../../dotfiles/.config/rofi;
        ".config/wofi".source = ../../dotfiles/.config/wofi;
        ".config/fastfetch".source = ../../dotfiles/.config/fastfetch;

        ".icewm".source = ../../dotfiles/.icewm;

        ".config/hypr/hyprland.conf".source = ../../dotfiles/.config/hypr/hyprland-desktop.conf;
        ".config/hypr/hypridle.conf".source = ../../dotfiles/.config/hypr/hypridle.conf;
        ".config/hypr/hyprlock.conf".source = ../../dotfiles/.config/hypr/hyprlock.conf;
        ".config/hypr/pyprland.toml".source = ../../dotfiles/.config/hypr/pyprland.toml;

        # Shortcuts
        ".local/share/applications/Calendar.desktop".source = ../../dotfiles/shortcuts/Calendar.desktop;
        ".local/share/applications/Notion.desktop".source = ../../dotfiles/shortcuts/Notion.desktop;
        ".local/share/applications/kew.desktop".source = ../../dotfiles/shortcuts/kew.desktop;
      };

    };
  }
