{
    discord-overlay = (self: super: { discord = super.discord.overrideAttrs (_: {
      src = builtins.fetchTarball {
        url = "https://discord.com/api/download/stable?platform=linux&format=tar.gz";
        sha256 = "1ymbrb5x0an088pk03nqp7vkcp4ischqpr8z7y3dvaskw3byxfaz";
      };
    });});
}