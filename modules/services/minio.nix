{ config, ... }:

{
  services.minio = {
    enable = true;
    listenAddress = ":9000";
    consoleAddress = ":9001";
    rootCredentialsFile = "${config.settings.user.homeDir}/etc/config-sensitive/minio/credentials";
  };
}
