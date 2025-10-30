{ config, lib, pkgs, ... }:
let
  userName = "shannony";
  hostName = "kara";
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
          shellAliases = {
            os-rebuild = "sudo nixos-rebuild switch --flake '/home/${userName}/nixos-valkyrie#${hostName}'";
            nixup = "~/Scripts/updates.sh";
            sync-remote = "~/Scripts/sync.sh";
          };
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

        # Social
        discord

        # File management
        keepassxc
        rclone
        yazi
        unzip
        unrar
        zip

        # Content
        krita
        kew
        obs-studio
        libreoffice-qt6

        # Utils
        imagemagick
        mpv
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
        ".config/wofi".source = ../../dotfiles/.config/wofi;
        ".config/fastfetch".source = ../../dotfiles/.config/fastfetch;

        ".config/hypr/hyprland.conf".source = ../../dotfiles/.config/hypr/hyprland-laptop.conf;
        ".config/hypr/hypridle.conf".source = ../../dotfiles/.config/hypr/hypridle.conf;
        ".config/hypr/hyprlock.conf".source = ../../dotfiles/.config/hypr/hyprlock.conf;
        ".config/hypr/pyprland.toml".source = ../../dotfiles/.config/hypr/pyprland.toml;
      };

    };
  }
