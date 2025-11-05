{
    os-rebuild = "sudo nixos-rebuild switch --flake ~/nixos-valkyrie#$(hostname)";
    nixup = "~/Scripts/updates.sh";
    dockup = "docker compose up -d";
    sync-remote = "~/Scripts/sync.sh";
}